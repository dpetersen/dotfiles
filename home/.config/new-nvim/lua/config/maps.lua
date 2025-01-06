-- Don't make me reach for Escape
vim.keymap.set("i", "jk", "<Esc>", { noremap = true })

-- Make Y behave to EOL like most capitalized normal-mode commands.
vim.keymap.set("n", "Y", "y$", { noremap = true })

-- Allow re-selection of last pasted text. Rewritten to Lua.
-- original source: http://vim.wikia.com/wiki/Selecting_your_pasted_text
vim.keymap.set("n", "gp", function()
    return '`[' .. string.sub(vim.fn.getregtype(), 1, 1) .. '`]'
end, { noremap = true, expr = true })

-- C-j in insert mode escapes normal mode and writes the file:
vim.keymap.set("i", "<C-j>", "<Esc>:w<Enter>", { noremap = true })

-- Relative file opening commands. Everytthing starts with leader:
--   - d[psv]: brings up an e/sp/vp prompt relative to the directory of the current file
--   - df: open current file's directory
--   - dd: opens up Vim's working directory
--
-- TODO: I can't tell if these are broken or it's screwy because of blink-cmp commandline completion issues?
vim.keymap.set("n", "<leader>dp", ":e " .. vim.fn.expand("%:h") .. "/", { noremap = true })
vim.keymap.set("n", "<leader>ds", ":sp " .. vim.fn.expand("%:h") .. "/", { noremap = true })
vim.keymap.set("n", "<leader>dv", ":vsp " .. vim.fn.expand("%:h") .. "/", { noremap = true })
vim.keymap.set("n", "<leader>df", "<leader>dp<CR>", { noremap = true })
vim.keymap.set("n", "<leader>dd", ":e .<CR>", { noremap = true })
