# Dotfiles Repository

This is a dotfiles repository managed by Chezmoi. The `.chezmoiroot` file
sets `home/` as the source root, so all managed dotfiles live under `home/`.

## Chezmoi Basics

Chezmoi maintains a source-of-truth copy of dotfiles and syncs them to/from
the home directory. Key commands:

- `chezmoi add <file>` / `chezmoi re-add <file>`: Start tracking a new file,
  or update the Chezmoi copy from the destination (home directory)
- `chezmoi apply [file]`: Overwrite destination with Chezmoi's version
- `chezmoi diff [file]`: Show what would change (destination vs source)
- `chezmoi unmanaged`: List files in home directory not tracked by Chezmoi
  (for auditing; will have many false positives)

## File Naming Conventions

Chezmoi uses naming prefixes in the source directory:

- `dot_` becomes `.` (e.g., `dot_config` → `.config`)
- `private_` sets restrictive permissions
- `.tmpl` suffix indicates a Go template (these cannot be re-added with
  `chezmoi re-add`; edit the source file directly instead)

## Sync Workflow

Changes typically drift in two directions:

1. **Uncommitted changes in Chezmoi**: Changes staged in jj but not yet
   pushed. These should generally be applied to the system first.
2. **Changes in destination**: Edits made directly to `~/.config/...` etc.
   that need to be synced back into Chezmoi and committed.

### Determining Sync Direction

Use these to understand what needs syncing:

```bash
# What's changed in Chezmoi but not yet applied?
chezmoi diff

# What's changed in jj?
jj status
jj diff

# What's different between Chezmoi and destination?
chezmoi diff <specific-file>
```

The diff output shows what `chezmoi apply` would do:
- Lines prefixed with `-` exist in **destination** (would be removed by apply)
- Lines prefixed with `+` exist in **Chezmoi source** (would be added by apply)

In other words: `-` is current state, `+` is what Chezmoi wants to write.

### CRITICAL: Choosing Between Apply and Re-add

**NEVER run `chezmoi re-add` or `chezmoi apply` without explicitly confirming
with the user which direction the sync should go.** Getting this wrong
overwrites data in one direction or the other, potentially losing work.

Before syncing, always:
1. Show the user the `chezmoi diff` output for each file with differences
2. Explain which versions are in source vs destination
3. Ask: "Should I apply (source → destination) or re-add (destination → source)?"
4. Wait for explicit confirmation before proceeding

Both commands accept specific file paths, allowing selective syncing:
- `chezmoi apply ~/.config/app/foo.json` - apply only this file
- `chezmoi re-add ~/.config/app/bar.json` - re-add only this file

This allows different files to sync in different directions based on where
the authoritative version lives.

When remote changes exist (after `jj git fetch`), be especially careful:
- Remote may have newer versions that should be applied to destination
- Or destination may have local changes that should be preserved
- **Always ask before deciding the sync direction for each file**

### Priority Order

1. First, check for uncommitted Chezmoi changes via `jj status`/`jj diff`
2. If there are pending changes, consider whether to apply them to the
   system with `chezmoi apply` before making new changes
3. Then sync destination changes back with `chezmoi re-add`
4. Make atomic commits for logical units of change

### Selective Syncing

Not all changes are ready to commit. Some files (like neovim's lazy-lock.json)
may have a mix of experimental and stable changes. In these cases:

- Use `chezmoi re-add <specific-file>` for files ready to commit
- Consider using `jj split` to separate changes within a file
- Leave experimental changes in the destination until ready

## Version Control

This repo uses Jujutsu (jj), not git directly. See global CLAUDE.md for
jj commit message conventions. Key jj commands for this repo:

```bash
jj status          # What's changed in working copy
jj diff            # Show working copy diff
jj log             # Recent history
jj commit -m "..."  # Commit current changes
jj new             # Start a new empty change
```

## Common Tasks

### Catching Up After Time Away

1. `jj status` - check for uncommitted Chezmoi changes
2. `chezmoi diff` - see what would change if applied
3. Decide: apply Chezmoi changes first, or re-add destination changes?
4. Make atomic commits grouping related changes

### Adding a New Dotfile

```bash
chezmoi add ~/.config/newapp/config.toml
jj status  # verify it was added
jj commit -m "Track newapp configuration"
```

### Updating an Existing Dotfile

```bash
# After editing ~/.config/app/config directly:
chezmoi re-add ~/.config/app/config
jj diff  # review changes
jj commit -m "Update app configuration"
```
