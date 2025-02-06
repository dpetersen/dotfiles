#!/bin/bash

# The version of tmux currently on bookworm is 3.2a (2022) and I'm having a
# hell of a time getting 256 color support working there in a way that's also
# compatible with current tmux versions. Backports has a modern version, so
# replace it.
sudo apt-get remove tmux
echo "deb http://deb.debian.org/debian bookworm-backports main" | sudo tee /etc/apt/sources.list.d/bookworm-backports.list
sudo apt-get update
sudo apt-get install -t bookworm-backports -y tmux

cd ~

sh -c "$(curl -fsLS get.chezmoi.io)"
mv ~/bin/chezmoi /usr/local/bin
rmdir bin

wget "https://github.com/jj-vcs/jj/releases/download/v0.26.0/jj-v0.26.0-aarch64-unknown-linux-musl.tar.gz"
mkdir jj-dl
mv jj-v0.26.0-aarch64-unknown-linux-musl.tar.gz jj-dl
cd jj-dl
tar -zxvf jj-v0.26.0-aarch64-unknown-linux-musl.tar.gz
sudo mv jj /usr/local/bin
cd ../
rm -rf jj-dl

jj git clone --colocate https://github.com/dpetersen/dotfiles ~/.local/share/chezmoi
chezmoi init --apply

# neovim in apt (at this time) is ancient. Because locally this is running on
# ARM64 (on modern Macs, anyway) and there are (currently) no free options for
# Github Actions and Linux ARM64, there are no pre-built binaries for Neovim on
# this platform. Sooooo...
sudo apt-get install -y ninja-build gettext cmake unzip curl build-essential
wget "https://github.com/neovim/neovim/archive/refs/tags/v0.10.3.tar.gz"
tar -zxvf v0.10.3.tar.gz
rm v0.10.3.tar.gz
cd neovim-0.10.3
make CMAKE_BUILD_TYPE=Release
sudo make install
cd ../
sudo rm -rf neovim-0.10.3

## Shell
sudo apt-get install -y fish
fish -c "fundle install"
sudo chsh -s /usr/bin/fish ${USER}

wget "https://github.com/starship/starship/releases/download/v1.21.1/starship-aarch64-unknown-linux-musl.tar.gz"
tar -zxvf starship-aarch64-unknown-linux-musl.tar.gz
sudo mv starship /usr/local/bin/starship
rm starship-aarch64-unknown-linux-musl.tar.gz

sudo apt-get install -y direnv autojump
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh

## Fancy Replacements
sudo apt install -y gpg
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza

sudo apt-get install -y fzf ripgrep jq jid

# There is a bat in Debian but it doesn't seem to be the one I'm expecting? At
# least not in the Debian version we're currently using.
wget "https://github.com/sharkdp/bat/releases/download/v0.24.0/bat-v0.24.0-aarch64-unknown-linux-gnu.tar.gz"
tar -zxvf bat-v0.24.0-aarch64-unknown-linux-gnu.tar.gz
sudo mv bat-v0.24.0-aarch64-unknown-linux-gnu/bat /usr/local/bin
rm -rf bat-v0.24.0-aarch64-unknown-linux-gnu*

wget "https://github.com/dandavison/delta/releases/download/0.18.2/delta-0.18.2-aarch64-unknown-linux-gnu.tar.gz"
tar -zxvf delta-0.18.2-aarch64-unknown-linux-gnu.tar.gz
sudo mv delta-0.18.2-aarch64-unknown-linux-gnu/delta /usr/local/bin/
rm -rf delta-0.18.2-aarch64-unknown-linux-gnu*

# There is an fd-find in Debian but when I install fd it's not found in the
# path?
wget "https://github.com/sharkdp/fd/releases/download/v10.2.0/fd-v10.2.0-aarch64-unknown-linux-gnu.tar.gz"
tar -zxvf fd-v10.2.0-aarch64-unknown-linux-gnu.tar.gz
sudo mv fd-v10.2.0-aarch64-unknown-linux-gnu/fd /usr/local/bin
rm -rf fd-v10.2.0-aarch64-unknown-linux-gnu*

npm install --global git-trim

# Installs fish support that will auto-change Ruby versions with RVM
curl -L --create-dirs -o ~/.config/fish/functions/rvm.fish https://raw.github.com/lunks/fish-nuggets/master/functions/rvm.fish
