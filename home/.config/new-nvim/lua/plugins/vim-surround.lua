return {
	-- The OG surround plugin. Still does what I want.
	{
		"tpope/vim-surround",
		dependencies = { { "tpope/vim-repeat" } },
	},
	-- Adds ERB to vim-surround, and a few mappings for creating HTML tags
	-- that I use rarely but still have in my fingers sometimes.
	{
		dependencies = { { "tpope/vim-surround" } },
		"tpope/vim-ragtag",
	},
}
