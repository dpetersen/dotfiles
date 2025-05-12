return {
	{
		"stevearc/oil.nvim",
		-- Optional, but looks good. He supports other icon sets if you want to switch.
		dependencies = { "echasnovski/mini.icons" },
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {
			view_options = {
				show_hidden = true,
				is_always_hidden = function(name, _)
					return name == ".." or name == ".git" or name == ".jj"
				end,
			},
		},
	},
}
