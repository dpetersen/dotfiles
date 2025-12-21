My dotfiles, in a format suitable for Chezmoi.

## Initializing

I'm generally usuing jj instead of git, but that isn't particularly well-supported in Chezmoi. To get started, run:

```bash
jj git clone --colocate https://github.com/dpetersen/dotfiles ~/.local/share/chezmoi
chezmoi init --apply
```

For a headless install, look at all the promptable items in `home/.chezmoi.toml.tmpl` and pass values for them. You can pass these on the command line:

```bash
chezmoi init --promptString email=you@example.com
```

## macOS Setup

Install dependencies from `install-osx.sh` (review and run the brew install commands).

After `chezmoi apply`, install fish plugins:

```bash
fish -c "fisher install < ~/.config/fish/fish_plugins"
```

## Generating Arch Package List

For backup purposes, there are two manifest files:
  - `pkglist-explicit.txt`: all the Arch packages I have installed
  - `pkglist.txt`  as [described here](https://wiki.archlinux.org/index.php/Pacman/Tips_and_tricks#List_of_installed_packages), which is every explicit and dependent package

Periodically regenerate that with:

```
./make-pkglists.sh
```
