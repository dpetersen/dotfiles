return {
	{
		"justinmk/vim-sneak",
		dependencies = { "tpope/vim-repeat" },
		-- I think I'm going to replace this with hop.nvim, which looks like
		-- it'll do everything I want here and some more useful stuff. I can't
		-- get sneak#label setting to work for some reason, but also hop looks
		-- pretty nice.
		enabled = false,
		config = function()
			vim.g["sneak#label"] = true
			vim.keymap.set("n", "<Leader>s", "<Plug>Sneak_s", { noremap = true })
			vim.keymap.set("n", "<Leader>S", "<Plug>Sneak_S", { noremap = true })
		end,
	},
}
