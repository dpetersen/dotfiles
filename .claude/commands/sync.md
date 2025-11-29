Sync dotfiles between Chezmoi and the destination.

Run these commands to assess the current state:

1. `jj status` and `jj diff` - uncommitted changes in Chezmoi
2. `chezmoi diff` - differences between Chezmoi source and destination

Summarize what you find, then ask the user how to proceed. Options:

- **Apply Chezmoi to destination**: `chezmoi apply [file]` for specific files
  or directories where Chezmoi should win
- **Re-add from destination**: `chezmoi re-add [file]` for files where the
  destination version should be pulled into Chezmoi
- **Mixed**: Some files may need apply, others re-add

After syncing, help organize changes into logical commits using jj.
Suggest atomic commit groupings based on what was changed.
