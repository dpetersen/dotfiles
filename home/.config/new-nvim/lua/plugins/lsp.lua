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
				"ruby_lsp",
				"rubocop",
				"ts_ls", -- for Typescript
				"taplo", -- for TOML (where the TOML follows a JSON schema)
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
		dependencies = { "saghen/blink.cmp" },
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({ capabilities = capabilities })
			lspconfig.ruby_lsp.setup({ capabilities = capabilities })
			lspconfig.gopls.setup({ capabilities = capabilities })
			lspconfig.taplo.setup({ capabilities = capabilities })

			-- If you're ever curious about what an LSP supports, you can do:
			--
			-- :lua =vim.lsp.get_clients()[2].server_capabilities
			--
			-- Where the index is the LSP server you're interested in.
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(ev)
					-- K is already remapped by default, so that functionality is
					-- available with no configuration.

					local bufferOpts = { buffer = ev.buf }
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufferOpts)
					vim.keymap.set("n", "<c-]>", vim.lsp.buf.definition, bufferOpts)

					vim.keymap.set("n", "grt", function()
						vim.lsp.buf.type_definition()
					end, { desc = "vim.lsp.buf.type_definition()" })
					vim.keymap.set("n", "gri", function()
						vim.lsp.buf.implementation()
					end, { desc = "vim.lsp.buf.implementation()" })

					-- These remaps are going to be part of the default configuration
					-- in Neovim 0.11. I'm going to start using them now.
					vim.keymap.set("n", "grn", function()
						vim.lsp.buf.rename()
					end, { desc = "vim.lsp.buf.rename()" })
					vim.keymap.set({ "n", "x" }, "gra", function()
						vim.lsp.buf.code_action()
					end, { desc = "vim.lsp.buf.code_action()" })
					vim.keymap.set("n", "grr", function()
						vim.lsp.buf.references()
					end, { desc = "vim.lsp.buf.references()" })
					-- End of 0.11 remaps
				end,
			})
		end,
	},
	-- lazydev.nvim is a plugin that properly configures LuaLS for editing
	-- your Neovim config
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {},
	},
	-- Autocompletion fanciness
	{
		"saghen/blink.cmp",
		dependencies = {
			{ "giuxtaposition/blink-cmp-copilot" },
		},
		version = "*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = { preset = "default" },
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer", "copilot" },
				providers = {
					copilot = {
						name = "copilot",
						module = "blink-cmp-copilot",
						score_offset = 100,
						async = true,
					},
				},
			},
			signature = { enabled = true },
		},
		opts_extend = { "sources.default" },
	},
	-- Provides link between blink and copilot.lua
	{
		"giuxtaposition/blink-cmp-copilot",
		dependencies = {
			"zbirenbaum/copilot.lua",
			-- Don't have copilot.lua visualize anything
			opts = {
				suggestion = { enabled = false },
				panel = { enabled = false },
			},
		},
	},
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
			},
			format_on_save = {
				lsp_format = "fallback",
			},
		},
	},
}
