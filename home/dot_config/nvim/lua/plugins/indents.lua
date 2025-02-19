return {
	{
		"lukas-reineke/indent-blankline.nvim",
		dependencies = { "HiPhish/rainbow-delimiters.nvim" },
		config = function()
			local macchiato = require("catppuccin.palettes").get_palette("macchiato")
			local highlight = {
				"RainbowRed",
				"RainbowYellow",
				"RainbowBlue",
				"RainbowOrange",
				"RainbowGreen",
				"RainbowViolet",
				"RainbowCyan",
			}
			local hooks = require("ibl.hooks")
			-- create the highlight groups in the highlight setup hook, so they are reset
			-- every time the colorscheme changes
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "RainbowRed", { blend = 0, fg = macchiato.red })
				vim.api.nvim_set_hl(0, "RainbowYellow", { blend = 0, fg = macchiato.yellow })
				vim.api.nvim_set_hl(0, "RainbowBlue", { blend = 0, fg = macchiato.blue })
				vim.api.nvim_set_hl(0, "RainbowOrange", { blend = 0, fg = macchiato.peach })
				vim.api.nvim_set_hl(0, "RainbowGreen", { blend = 0, fg = macchiato.green })
				vim.api.nvim_set_hl(0, "RainbowViolet", { blend = 0, fg = macchiato.mauve })
				vim.api.nvim_set_hl(0, "RainbowCyan", { blend = 0, fg = macchiato.teal })
			end)

			vim.g.rainbow_delimiters = { highlight = highlight }
			require("ibl").setup({ scope = { highlight = highlight } })

			hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
		end,
	},
}
