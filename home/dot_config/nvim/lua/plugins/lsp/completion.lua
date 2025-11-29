return {
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
					-- Show docs automatically when selecting a completion item
					auto_show = true,
				},
			},
			-- Default keymap reference: https://cmp.saghen.dev/configuration/keymap.html
			-- Ctrl-b/f: scroll documentation
			-- Ctrl-space: force show completion window
			-- Ctrl-e: hide completion window
			appearance = {
				-- Use nvim-cmp highlight groups for easier theme compatibility
				use_nvim_cmp_as_default = true,
				kind_icons = {
					Copilot = "",
				},
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer", "copilot" },
				providers = {
					copilot = {
						name = "copilot",
						module = "blink-copilot",
						-- Prioritize copilot suggestions in the completion list
						score_offset = 100,
						async = true,
					},
				},
			},
			-- Show function signature help while typing arguments
			signature = { enabled = true },
		},
		-- Allow other plugin specs to extend sources.default
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
		dependencies = {
			{
				"zbirenbaum/copilot.lua",
				opts = {
					-- Disable native suggestion/panel to use blink-copilot instead
					suggestion = { enabled = false },
					panel = { enabled = false },
				},
			},
		},
	},
}
