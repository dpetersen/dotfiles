-- Minimal neovim config for quick editing (commit messages, Alt-v in shell, etc.)
-- Uses NVIM_APPNAME=nvim-minimal to load this instead of full config.

-- Escape insert mode without reaching for Escape
vim.keymap.set("i", "jk", "<Esc>")

-- Escape and save in one motion (great for commit messages)
vim.keymap.set("i", "<C-j>", "<Esc>:w<CR>")

-- Line numbers
vim.opt.number = true

-- Smart case search
vim.opt.ignorecase = true
vim.opt.smartcase = true
