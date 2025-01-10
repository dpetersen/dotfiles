return {
	{
		"nvim-treesitter/nvim-treesitter",
		main = "nvim-treesitter.configs",
		dependencies = {
			-- A treesitter-aware version of matchit. Can work without treesitter but it's
			-- significantly faster with treesitter enabled in large files.
			"andymass/vim-matchup",
			-- Just a treesitter-aware port of tpope/endwise that works in a few languages
			"RRethy/nvim-treesitter-endwise",
		},
		opts = {
			auto_install = true,
			highlight = {
				enable = true,
			},
			endwise = { enable = true },
			matchup = { enable = true },
		},
	},
}
