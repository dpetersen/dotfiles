return {
	{
		-- Run specs from inside Neovim
		"nvim-neotest/neotest",
		keys = { "<leader>t" },
		dependencies = {
			-- Their documented dependencies
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",

			-- Adapters I use
			"olimorris/neotest-rspec",
			"nvim-neotest/neotest-go",
			"nvim-neotest/neotest-jest",
			"nvim-neotest/neotest-python",
		},
		-- Can't be ops because the adapters block tries to evaluate before the dependencies are installed
		config = function()
			local neotest = require("neotest")
			----@module "neotest"
			----@type neotest.Config
			---@diagnostic disable-next-line: missing-fields
			neotest.setup({
				adapters = {
					require("neotest-rspec")({
						rspec_cmd = function()
							-- TODO: Would be great to have this be dynamic. Based on the existence of bin/spring and switch to the binstub?
							return { "bundle", "exec", "spring", "rspec" }
						end,
					}),
					require("neotest-go"),
					require("neotest-jest")({
						jestCommand = "npm test --",
						jestConfigFile = "custom.jest.config.ts",
						env = { CI = true },
						cwd = function()
							return vim.fn.getcwd()
						end,
					}),
					require("neotest-python"),
				},
			})

			local function nrs(opts)
				return vim.tbl_deep_extend("force", { noremap = true, silent = true }, opts)
			end

			vim.keymap.set("n", "<leader>ts", neotest.summary.toggle, nrs({ desc = "Toggle test summary" }))
			-- TODO: decide if you want the floating output thing or maybe diagnostics? Do you need to install the neotest rspec adapter?
			vim.keymap.set("n", "<leader>to", neotest.output_panel.toggle, nrs({ desc = "Toggle test output panel" }))
			vim.keymap.set("n", "<leader>tn", neotest.run.run, nrs({ desc = "Run nearest test" }))
			vim.keymap.set("n", "<leader>tt", neotest.run.run_last, nrs({ desc = "Re-run last test" }))
			vim.keymap.set("n", "<leader>tf", function()
				neotest.run.run(vim.fn.expand("%"))
			end, nrs({ desc = "Run tests in file" }))
			vim.keymap.set("n", "<leader>tS", neotest.run.stop, nrs({ desc = "Stop running tests" }))
		end,
	},
}
