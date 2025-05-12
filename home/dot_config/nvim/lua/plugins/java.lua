return {
	"mfussenegger/nvim-jdtls",
	-- FIXME: This is running it on every file I open, which is painful. Figure out how to integrate this properly like your other LSPs.
	enabled = false,
	config = function()
		local config = {
			cmd = { "/Users/donald.petersen/.local/share/nvim/mason/bin/jdtls" },
			root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
		}
		require("jdtls").start_or_attach(config)
	end,
}
