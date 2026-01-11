def datavant?
  `scutil --get ComputerName`.strip.start_with?("DV-")
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
brew "mas"

cask "1password"
cask "arc"
cask "font-fira-code"
cask "ghostty"
cask "google-chrome"
cask "obsidian"
cask "raycast"
mas "Session - Pomodoro Focus Timer", id: 1521432881
cask "shortcat"
cask "tidal"

cask "superwhisper" unless datavant?  # Blocked by Zscaler

if datavant?
  cask "cursor"
  cask "docker-desktop"
  cask "intellij-idea"
  cask "loom"
  cask "microsoft-outlook"
end
