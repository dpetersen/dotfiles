return {
	-- Detects and activates Python virtual environments from poetry, uv, pyenv, etc.
	-- Remembers selection per directory and auto-activates on return.
	-- Automatically updates pyright when you switch environments.
	{
		"linux-cultist/venv-selector.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-telescope/telescope.nvim",
		},
		ft = "python",
		keys = {
			{ "<leader>fv", "<cmd>VenvSelect<cr>", desc = "Select Python virtualenv" },
		},
		opts = {},
	},
}
