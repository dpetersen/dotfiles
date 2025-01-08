return {
	-- An updated splitjoin plugin that works via treesitter. Works on
	-- stuff that splitjoin ignored.
	"Wansmer/treesj",
	keys = { "gJ", "gS" },
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	opts = {
		-- I learned splitjoin's default keymaps, which are different
		use_default_keymaps = false,
	},
	config = function()
		local treesj = require("treesj")
		-- Mimicking what I learned from splitjoin
		vim.keymap.set("n", "gS", treesj.split, { noremap = true })
		vim.keymap.set("n", "gJ", treesj.join, { noremap = true })
	end,
}
