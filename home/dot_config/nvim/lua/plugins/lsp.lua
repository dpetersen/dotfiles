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
		dependencies = { "saghen/blink.cmp" },
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({ capabilities = capabilities })
			lspconfig.ruby_lsp.setup({ capabilities = capabilities })
			lspconfig.gopls.setup({ capabilities = capabilities })
			lspconfig.taplo.setup({ capabilities = capabilities })
			lspconfig.ts_ls.setup({ capabilities = capabilities })
			lspconfig.rust_analyzer.setup({ capabilities = capabilities })
			lspconfig.ruff.setup({ capabilities = capabilities })
			-- Many of these settings to play nice with Ruff come from:
			-- https://docs.astral.sh/ruff/editors/setup/#neovim
			lspconfig.pyright.setup({
				settings = {
					pyright = {
						-- Using Ruff's import organizer
						disableOrganizeImports = true,
					},
					-- python = {
					-- 	analysis = {
					-- 		-- Ignore all files for analysis to exclusively use Ruff for linting
					-- 		ignore = { "*" },
					-- 	},
					-- },
				},
			})

			-- If you're ever curious about what an LSP supports, you can do:
			--
			-- :lua =vim.lsp.get_clients()[2].server_capabilities
			--
			-- Where the index is the LSP server you're interested in.
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(ev)
					-- K is already remapped by default, so that functionality is
					-- available with no configuration.

					vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Go to definition" })
					vim.keymap.set("n", "<c-]>", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Go to definition" })

					vim.keymap.set("n", "grt", function()
						vim.lsp.buf.type_definition()
					end, { desc = "Go to type definition" })
					vim.keymap.set("n", "gri", function()
						vim.lsp.buf.implementation()
					end, { desc = "Go to implementation" })

					-- These remaps are going to be part of the default configuration
					-- in Neovim 0.11. I'm going to start using them now.
					vim.keymap.set("n", "grn", function()
						vim.lsp.buf.rename()
					end, { desc = "Rename symbol" })
					vim.keymap.set({ "n", "x" }, "gra", function()
						vim.lsp.buf.code_action()
					end, { desc = "Show code actions" })
					vim.keymap.set("n", "grr", function()
						vim.lsp.buf.references()
					end, { desc = "Find references" })
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
		opts = {
			library = { "nvim-dap-ui" },
		},
	},
	-- Autocompletion fanciness
	{
		"saghen/blink.cmp",
		dependencies = {
			{ "fang2hou/blink-copilot" },
		},
		version = "*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			completion = {
				documentation = {
					auto_show = true,
				},
			},
			-- These are described here:
			--
			-- https://cmp.saghen.dev/configuration/keymap.html#default
			--
			-- Most are defaults, but a few helpful ones:
			--
			-- Ctrl-b/f scroll documentation
			-- Ctrl-space force show completion window (useful for kicking copilot off)
			-- Ctrl-e hide completion window
			keymap = { preset = "default" },
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
				kind_icons = {
					Copilot = "",
				},
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer", "copilot" },
				providers = {
					copilot = {
						name = "copilot",
						module = "blink-copilot",
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
		"fang2hou/blink-copilot",
		-- This is still providing the copilot completions, and you need to do:
		--
		-- :Copilot auth
		--
		-- To authenticate with Github and enable these completions.
		dependencies = { "zbirenbaum/copilot.lua", opts = {} },
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
				rust = { "clippy" },
			},
			format_on_save = {
				lsp_format = "fallback",
			},
		},
	},
}
