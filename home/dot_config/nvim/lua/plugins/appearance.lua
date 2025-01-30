return {
	{
		"jnurmine/Zenburn",
		-- Lazy suggests ensuring your main colorscheme loads immediately
		lazy = false,
		-- TODO: decide if I'm moving to catppuccin or staying on Zenburn
		enabled = false,
		priority = 1000,
		init = function()
			-- It's not *that* high contrast, just a darker background
			vim.g.zenburn_high_Contrast = 1
			vim.cmd("colorscheme zenburn")
		end,
	},
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
			-- There are more integrations than this, but many are enabled by default.
			-- You can find out what's on by default in the source:
			-- https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/init.lua
			integrations = {
				hop = true,
				blink_cmp = true,
				mason = true,
				neotest = true,
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
