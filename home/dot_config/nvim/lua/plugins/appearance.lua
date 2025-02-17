return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		-- Lazy suggests ensuring your main colorscheme loads immediately
		lazy = false,
		priority = 1000,
		init = function()
			vim.cmd.colorscheme("catppuccin-macchiato")
		end,
		opts = {
			custom_highlights = function(colors)
				return {
					-- Diff colors are way too subtle for me, so this sticks to theme colors but
					-- makes them much louder.
					DiffChange = { bg = colors.surface1 },
					-- TODO: I want this to take effect for JJDiffSplit but not other diffs
					DiffText = { bg = colors.red },
				}
			end,
			-- There are more integrations than this, but many are enabled by default.
			-- You can find out what's on by default in the source:
			-- https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/init.lua
			integrations = {
				hop = true,
				blink_cmp = true,
				mason = true,
				neotest = true,
				-- These two are disabled because, while they are supported by cattpuccin.nvim
				-- via integrations, it's not configured quite right when both plugins are present,
				-- as far as I can tell.
				rainbow_delimiters = false,
				indent_blankline = { enabled = false },
			},
		},
	},
	-- Easy, pretty statusline
	{ "bling/vim-airline" },
	-- Themes for vim-airline
	{
		dependencies = { "bling/vim-airline" },
		"vim-airline/vim-airline-themes",
		init = function()
			vim.g.airline_theme = "catppuccin"
		end,
	},
	-- Pushes airline theme to tmux. Annoying that I have to run vim to make
	-- tmux look right, but the consistent look and one less thing to configure
	-- is worth it to me.
	{ "edkolev/tmuxline.vim" },
}
