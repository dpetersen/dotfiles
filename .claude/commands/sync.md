Sync dotfiles between Chezmoi and the destination.

## Step 1: Assess local state

1. `jj status` and `jj diff` - uncommitted changes in working copy
2. `jj log -r 'ancestors(@, 5)'` - recent local commits
3. `chezmoi diff` - differences between Chezmoi source and destination

## Step 2: Get local clean

Resolve any chezmoi differences before fetching remote changes.

**CRITICAL: Before running `chezmoi apply` or `chezmoi re-add`, you MUST:**
1. Show the user the `chezmoi diff` output for each file
2. Explain what's in source vs destination for each file
3. Ask the user which direction to sync each file
4. Wait for explicit confirmation before proceeding

Sync options (can mix per-file):
- **Apply Chezmoi to destination**: `chezmoi apply [file]` - source wins
- **Re-add from destination**: `chezmoi re-add [file]` - destination wins

Help organize changes into logical commits. Even WIP commits are fine at this
stage - the goal is to have `chezmoi diff` clean before pulling.

## Step 3: Fetch and rebase if needed

1. `jj git fetch` - fetch latest from origin
2. Check if rebase is needed by comparing local to `main@origin`:
   - If working copy is empty and already on main, skip rebase
   - If there are local non-empty commits not in main, run
     `jj rebase -d main@origin`

## Step 4: Prepare for new work

Ensure we end on an empty commit ready for new work:
- If the current commit is empty, we're already set
- If the current commit has changes and a proper description, run `jj new`
- Exception: if the latest commit is clearly WIP, leave it as-is so the user
  can continue working on it
