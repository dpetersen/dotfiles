local default_opts = { noremap = true }
local function merge(opts)
	return vim.tbl_deep_extend("force", default_opts, opts or {})
end

-- Don't make me reach for Escape
vim.keymap.set("i", "jk", "<Esc>", default_opts)

-- Make Y behave to EOL like most capitalized normal-mode commands.
vim.keymap.set("n", "Y", "y$", merge({ desc = "Yank to end of line" }))

-- Rewritten to Lua. Original source:
-- http://vim.wikia.com/wiki/Selecting_your_pasted_text
vim.keymap.set("n", "gp", function()
	return "`[" .. string.sub(vim.fn.getregtype(), 1, 1) .. "`]"
end, merge({ expr = true, desc = "Re-select last pasted text" }))

-- C-j in insert mode escapes normal mode and writes the file:
vim.keymap.set("i", "<C-j>", "<Esc>:w<Enter>", default_opts)

-- Relative file opening commands. Everything starts with leader:
--   - d[psv]: brings up an e/sp/vp prompt relative to the directory of the current file
--   - df: open current file's directory
--   - dd: opens up Vim's working directory
vim.keymap.set("n", "<leader>dp", function()
	return ":e " .. vim.fn.expand("%:h") .. "/"
end, merge({ expr = true, desc = "Open current buffer's parent directory" }))
vim.keymap.set("n", "<leader>ds", function()
	return ":sp " .. vim.fn.expand("%:h") .. "/"
end, merge({ expr = true, desc = "VSplit current buffer's parent directory" }))
vim.keymap.set("n", "<leader>dv", function()
	return ":vsp " .. vim.fn.expand("%:h") .. "/"
end, merge({ expr = true, desc = "Split current buffer's parent directory" }))

-- Move between splits with Ctrl + hjkl
vim.keymap.set("n", "<C-j>", "<C-W>j", default_opts)
vim.keymap.set("n", "<C-k>", "<C-W>k", default_opts)
vim.keymap.set("n", "<C-l>", "<C-W>l", default_opts)
vim.keymap.set("n", "<C-h>", "<C-W>h", default_opts)

-- Close/open quickfix/preview windows from anywhere. Why has it taken me so long to map this?
vim.keymap.set("n", "<leader>qq", ":cclose<CR>", merge({ desc = "Close quickfix" }))
vim.keymap.set("n", "<leader>qp", ":pclose<CR>", merge({ desc = "Close preview" }))
vim.keymap.set("n", "<leader>qo", ":copen<CR>", merge({ desc = "Open quickfix" }))

-- bind \ to clear highlighting, though search term remains and 'n' will
-- re-search and highlight it
vim.keymap.set("n", "\\", ":nohlsearch<CR>", merge({ silent = true, desc = "Stop highlighting search result" }))
