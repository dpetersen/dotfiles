return {
	{
		-- Split and edit Jujutsu diffs. Requires configuration in jj to
		-- actually use this tool, as described in:
		-- https://github.com/julienvincent/hunk.nvim
		"julienvincent/hunk.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		cmd = { "DiffEditor" },
		config = function()
			require("hunk").setup()
		end,
	},
}
