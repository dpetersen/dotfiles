return {
	{
		"nvim-telescope/telescope.nvim",
		keys = { "<leader>f" },
		config = function()
			local telescope = require("telescope.builtin")

			local keymaps = {
				["f"] = telescope.find_files,
				["b"] = telescope.buffers,
				["g"] = telescope.live_grep,
				["h"] = telescope.help_tags,
				["t"] = telescope.treesitter,
				["s"] = telescope.lsp_document_symbols,
				["S"] = telescope.lsp_dynamic_workspace_symbols,
				["nf"] = function()
					telescope.find_files({
						cwd = vim.fn.stdpath("config"),
						prompt_title = "Neovim Config",
						-- Needs to follow symlinks because my configs are symlinked by homeshick!
						follow = true,
						hidden = true,
					})
				end,
				-- TODO: This isn't functioning yet, but I'm guessing it's because of homeshick and symlinks.
				-- Probably need to follow the symlink to its source?
				["ng"] = function()
					telescope.live_grep({
						cwd = vim.fn.stdpath("config"),
						prompt_title = "Neovim Config",
					})
				end,
			}

			for key, command in pairs(keymaps) do
				vim.keymap.set("n", "<Leader>f" .. key, command, { noremap = true })
			end
		end,
	},
}
