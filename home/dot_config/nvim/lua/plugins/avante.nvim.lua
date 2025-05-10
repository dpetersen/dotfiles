return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	build = "make",
	dependencies = {
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
		"zbirenbaum/copilot.lua", -- for providers='copilot'
	},
	opts = {
		---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
		provider = "claude",
		behavior = {
			use_cwd_as_project_root = true,
			-- 	enable_cursor_planning_mode = true,
		},
		-- claude = {
		-- 	disable_tools = true,
		-- },
	},
}
