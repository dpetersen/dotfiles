-- Extended auto-indent support
vim.opt.smartindent = true

-- Use spaces instead of tabs at the start of the line
vim.opt.expandtab = true

-- Highlight the line that the cursor is on.
vim.opt.cursorline = true

-- Always show line numbers
vim.opt.number = true

-- Reset the window title in non-GUI mode to something a little more helpful.
vim.opt.title = true

-- Allows special characters in files to create folds
vim.opt.foldmethod = "marker"

-- Sets autocompletion behavior:
--   - longest: complete till longest common strong
--   - full,full: shows all submatches as normal
vim.opt.wildmode = "longest:full,full"

-- The minimum height of a window. This is zero-based, so 1 line minimum.
vim.opt.winminheight = 0

-- Create new splits right/below instead of left/above
vim.opt.splitbelow = true
vim.opt.splitright = true


-- Always show diffs vertically regardless of the space available. Horizontal
-- diffs are unreadable to me.
vim.opt.diffopt = "vertical"
