return {
	-- A replacement for my old friend vim-sneak, which I was having a bit of trouble configuring here
	-- in Lazy. This is significantly more configurable and supports multi-window searching, which is awesome.
	{
		"smoka7/hop.nvim",
		keys = { "<leader>h" },
		config = function()
			local hop = require("hop")
			hop.setup()

			-- All the mappings have a lower-case and upper-case version to denote single/multi-window

			-- HopWord
			vim.keymap.set("n", "<Leader>hw", hop.hint_words, { noremap = true })
			vim.keymap.set("n", "<Leader>hW", function()
				hop.hint_words({ multi_windows = true })
			end, { noremap = true })

			-- HopPattern
			vim.keymap.set("n", "<Leader>h/", hop.hint_patterns, { noremap = true })
			vim.keymap.set("n", "<Leader>h?", function()
				hop.hint_patterns({ multi_windows = true })
			end, { noremap = true })
		end,
	},
}
