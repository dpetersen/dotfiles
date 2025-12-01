Sync dotfiles between Chezmoi and the destination.

## Step 1: Assess local state

1. `jj status` and `jj diff` - uncommitted changes in working copy
2. `jj log -r 'ancestors(@, 5)'` - recent local commits
3. `chezmoi diff` - differences between Chezmoi source and destination

## Step 2: Get local clean

Resolve any chezmoi differences before fetching remote changes:

- **Apply Chezmoi to destination**: `chezmoi apply [file]` for specific files
  or directories where Chezmoi should win
- **Re-add from destination**: `chezmoi re-add [file]` for files where the
  destination version should be pulled into Chezmoi
- **Mixed**: Some files may need apply, others re-add

Help organize changes into logical commits. Even WIP commits are fine at this
stage - the goal is to have `chezmoi diff` clean before pulling.

## Step 3: Fetch and rebase if needed

1. `jj git fetch` - fetch latest from origin
2. Check if rebase is needed by comparing local to `master@origin`:
   - If working copy is empty and already on master, skip rebase
   - If there are local non-empty commits not in master, run
     `jj rebase -d master@origin`

## Step 4: Prepare for new work

Ensure we end on an empty commit ready for new work:
- If the current commit is empty, we're already set
- If the current commit has changes and a proper description, run `jj new`
- Exception: if the latest commit is clearly WIP, leave it as-is so the user
  can continue working on it
