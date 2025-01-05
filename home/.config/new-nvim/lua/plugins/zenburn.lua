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
}
