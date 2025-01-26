My dotfiles, in a format suitable for Chezmoi.

## Initializing

I'm generally usuing jj instead of git, but that isn't particularly well-supported in Chezmoi. To get started, run:

```bash
jj git clone --colocate https://github.com/dpetersen/dotfiles ~/.local/share/chezmoi
chezmoi init
```

## Generating Arch Package List

For backup purposes, the file `pkglist.txt` has all the Arch packages I have installed, as [described here](https://wiki.archlinux.org/index.php/Pacman/Tips_and_tricks#List_of_installed_packages). Periodically regenerate that with:

```
pacman -Qqe > pkglist.txt
```
