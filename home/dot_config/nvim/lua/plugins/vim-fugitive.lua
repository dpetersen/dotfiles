return {
	{
		"tpope/vim-fugitive",
		config = function()
			local noremap = { noremap = true }
			vim.keymap.set("n", "<leader>gs", ":Git<CR>", { noremap = true, desc = "Git Status" })
			vim.keymap.set("n", "<leader>gc", ":Git commit<CR>", { noremap = true, desc = "Git Commit" })
			vim.keymap.set("n", "<leader>gd", ":Gdiffsplit<CR>", { noremap = true, desc = "Git Diff" })
			vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", { noremap = true, desc = "Git Blame" })
		end,
	},
}
