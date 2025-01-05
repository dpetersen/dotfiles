return {
	{
		"nvim-telescope/telescope.nvim",
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
			}

			for key, command in pairs(keymaps) do
				vim.keymap.set("n", "<Leader>f" .. key, command, { noremap = true })
			end
		end,
	},
}
