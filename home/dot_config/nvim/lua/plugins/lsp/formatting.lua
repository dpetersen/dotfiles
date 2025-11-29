return {
	-- LSP-aware formatting with easily configurable format-on-save
	{
		"stevearc/conform.nvim",
		-- Their recommended lazy loading configuration
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		---@module "conform"
		---@type conform.setupOpts
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				ruby = { "standardrb", timeout_ms = 5000 },
				typescript = { "prettierd" },
				typescriptreact = { "prettierd" },
				rust = { "rustfmt" },
				python = { "ruff_fix", "ruff_format" },
			},
			format_on_save = {
				lsp_format = "fallback",
			},
		},
	},
}
