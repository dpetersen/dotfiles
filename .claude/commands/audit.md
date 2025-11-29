Audit unmanaged dotfiles to find files that might need tracking.

Run `chezmoi unmanaged` to list files in the home directory not tracked by
Chezmoi.

This will have many false positives (caches, app data, etc.). Filter the
output to highlight files that are likely configuration worth tracking:

- Files in `.config/` directories
- Shell config files (`.bashrc`, `.zshrc`, etc.)
- Tool-specific dotfiles (`.gitconfig`, `.npmrc`, etc.)

Ignore common noise:
- Cache directories
- Application state/data directories
- Generated files
- Directories that are mostly binary/data

Present a filtered list of candidates that might be worth adding to Chezmoi,
and ask the user which (if any) they'd like to start tracking.
