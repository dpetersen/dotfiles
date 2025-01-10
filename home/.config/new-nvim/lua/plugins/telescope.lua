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
				-- TODO: these aren't working yet, but seems like they should and they would be useful
				["nf"] = function()
					telescope.find_files({
						cwd = vim.fn.stdpath("config"),
						prompt_title = "Neovim Config",
						hidden = true,
					})
				end,
				["ng"] = function()
					telescope.live_grep({
						cwd = vim.fn.stdpath("config"),
						prompt_title = "Neovim Config",
						hidden = true,
					})
				end,
			}

			for key, command in pairs(keymaps) do
				vim.keymap.set("n", "<Leader>f" .. key, command, { noremap = true })
			end
		end,
	},
}
