# vim: set ft=ruby :

def launch_darkly?
  `scutil --get ComputerName`.strip == "Don’s MacBook Pro"
end

brew "node"  # Nvim copilot.lua needs this
brew "neovim"
brew "jj"
brew "fzf"
brew "starship"
brew "atuin"
brew "tmux"
brew "direnv"
brew "asdf"
brew "eza"
brew "jq"
brew "jid"
brew "go"
brew "topgrade"
brew "git-delta"
brew "ripgrep"
brew "fd"
brew "bat"
brew "wget"
brew "watch"
brew "zellij"
brew "hl"
brew "dust"
brew "btop"
brew "chezmoi"
brew "fish"
brew "fisher"
brew "gh"
brew "grep"
brew "lynx"
brew "mise"
brew "pgcli"
brew "tree-sitter"
brew "yq"
brew "zoxide"
brew "ast-grep"
brew "uv"

cask "arc"
cask "font-fira-code"
cask "ghostty"
cask "obsidian"
cask "raycast"
cask "shortcat"
cask "tidal"
cask "superwhisper"

brew "mas"
mas "Session - Pomodoro Focus Timer", id: 1521432881

if !launch_darkly?

  # These already come installed
  cask "1password"
  cask "google-chrome"
end

if launch_darkly?
  cask "loom"
end
