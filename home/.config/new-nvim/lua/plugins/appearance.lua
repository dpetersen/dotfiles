return {
	{
		"jnurmine/Zenburn",
		-- Lazy suggests ensuring your main colorscheme loads
		-- immediately
		lazy = false,
		priority = 1000,
		config = function()
			-- It's not *that* high contrast, just a darker
			-- background
			vim.g.zenburn_high_Contrast = 1
			vim.cmd("colorscheme zenburn")
		end,
	},
	-- Easy, pretty statusline
	{ "bling/vim-airline" },
	-- Themes for vim-airline
	{
		dependencies = { "bling/vim-airline" },
		"vim-airline/vim-airline-themes",
		init = function()
			vim.g.airline_theme = "zenburn"
		end,
	},
	-- Pushes airline theme to tmux. Annoying that I have to run vim to
	-- make tmux look right, but the consistent look and one less thing to
	-- configure is worth it to me.
	{ "edkolev/tmuxline.vim" },
}
