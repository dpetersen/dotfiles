return {
	{
		"nvim-telescope/telescope.nvim",
		keys = { "<leader>f" },
		config = function()
			local telescope = require("telescope.builtin")

			local keymaps = {
				["f"] = { command = telescope.find_files, desc = "Files" },
				["b"] = { command = telescope.buffers, desc = "Buffers" },
				["g"] = { command = telescope.live_grep, desc = "Grep" },
				["h"] = { command = telescope.help_tags, desc = "Helptags" },
				["t"] = { command = telescope.treesitter, desc = "Treesitter symbols" },
				["s"] = { command = telescope.lsp_document_symbols, desc = "LSP document symbols" },
				["S"] = { command = telescope.lsp_dynamic_workspace_symbols, desc = "LSP workspace symbols" },
				["nf"] = {
					command = function()
						telescope.find_files({
							cwd = vim.fn.stdpath("config"),
							prompt_title = "Neovim Config",
							-- Needs to follow symlinks because my configs are symlinked by homeshick!
							follow = true,
							hidden = true,
						})
					end,
					desc = "Files in Neovim config",
				},
				-- TODO: This isn't functioning yet, but I'm guessing it's because of homeshick and symlinks.
				-- Probably need to follow the symlink to its source?
				["ng"] = {
					command = function()
						telescope.live_grep({
							cwd = vim.fn.stdpath("config"),
							prompt_title = "Neovim Config",
						})
					end,
					desc = "Grep in Neovim config",
				},
			}

			for key, map in pairs(keymaps) do
				vim.keymap.set("n", "<Leader>f" .. key, map.command, { noremap = true, desc = map.desc })
			end
		end,
	},
}
