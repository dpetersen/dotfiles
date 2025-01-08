return {
	{
		-- Run specs from inside Neovim
		"nvim-neotest/neotest",
		dependencies = {
			-- Their documented dependencies
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",

			-- Adapters I use
			"olimorris/neotest-rspec",
		},
		opts = {
			adapters = {
				require("neotest-rspec"),
			},
		},
	},
}
