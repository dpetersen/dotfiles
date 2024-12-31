#!/bin/bash

cd ~

sudo apt-get update

# Get all my dotfiles installed and linked
git clone https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
homeshick clone dpetersen/dotfiles
homeshick cd dotfiles
git checkout -t origin/ic-work
homeshick link dotfiles --force

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
rm -rf neovim-0.10.3

nvim --headless +PlugInstall +qall
nvim --headless +TSUpdateSync +qall

## Shell
sudo apt-get install -y fish
fish -c "fundle install"

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

sudo apt-get install -y fd-find fzf ripgrep jq jid

# There is a bat in debian but it doesn't seem to be the one I'm expecting? At
# least not in the Debian version we're currently using.
wget "https://github.com/sharkdp/bat/releases/download/v0.24.0/bat-v0.24.0-aarch64-unknown-linux-gnu.tar.gz"
tar -zxvf bat-v0.24.0-aarch64-unknown-linux-gnu.tar.gz
sudo mv bat-v0.24.0-aarch64-unknown-linux-gnu/bat /usr/local/bin
rm -rf bat-v0.24.0-aarch64-unknown-linux-gnu*

wget "https://github.com/dandavison/delta/releases/download/0.18.2/delta-0.18.2-aarch64-unknown-linux-gnu.tar.gz"
tar -zxvf delta-0.18.2-aarch64-unknown-linux-gnu.tar.gz
sudo mv delta-0.18.2-aarch64-unknown-linux-gnu/delta /usr/local/bin/
rm -rf delta-0.18.2-aarch64-unknown-linux-gnu*

npm install --global git-trim

wget "https://github.com/jj-vcs/jj/releases/download/v0.24.0/jj-v0.24.0-aarch64-unknown-linux-musl.tar.gz"
mkdir jj-dl
mv jj-v0.24.0-aarch64-unknown-linux-musl.tar.gz jj-dl
cd jj-dl
tar -zxvf jj-v0.24.0-aarch64-unknown-linux-musl.tar.gz
sudo mv jj /usr/local/bin
cd ../
rm -rf jj-dl

gpg --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash
curl -L --create-dirs -o ~/.config/fish/functions/rvm.fish https://raw.github.com/lunks/fish-nuggets/master/functions/rvm.fish
