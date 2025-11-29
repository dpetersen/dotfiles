return {
	-- Manager UI for LSPs, Linters, and other external tools
	{
		"williamboman/mason.nvim",
		-- Mason recommends it should not be lazy loaded
		lazy = false,
		opts = {},
	},
	-- Bridges the gap between lspconfig and mason
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			-- List of allowed values:
			-- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
			--
			-- Linters and other tools that you can't find in that list are probably installable
			-- with mason-tool-installer below.
			ensure_installed = {
				"lua_ls",
				"rust_analyzer",
				"gopls",
				-- "ruby_lsp",
				-- "rubocop",
				"ts_ls", -- for Typescript
				"taplo", -- for TOML (where the TOML follows a JSON schema)
				"ruff",
				"pyright",
				"jdtls",
			},
		},
	},
	-- Helps installing other tools, like linters and formatters, that aren't available in nvim-lspconfig.
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				"stylua",
				"prettierd",
			},
		},
	},
	-- Official plugin with prebuilt configurations for languages
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- Enable ruby_lsp manually since it's not in mason's ensure_installed
			-- (managed by the Ruby ecosystem instead)
			vim.lsp.enable("ruby_lsp")

			-- If you're ever curious about what an LSP supports, you can do:
			--
			-- :lua =vim.lsp.get_clients()[2].server_capabilities
			--
			-- Where the index is the LSP server you're interested in.
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(ev)
					-- K is already remapped by default, so that functionality is
					-- available with no configuration.
					-- A bunch of helpful mappings are available with: help grr

					vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Go to definition" })
					vim.keymap.set("n", "<c-]>", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Go to definition" })
				end,
			})
		end,
	},
}
