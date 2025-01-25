return {
	-- New text objects to work with (AI = around/in), like function call or
	-- arguments. Includes n/l for next/last to search forward/back for objects.
	{
		"echasnovski/mini.ai",
		opts = {},
	},
	-- New operators to act on text objects, like:
	--
	--   g= evaluate
	--   gx exchange
	--   gm multiply
	--   gR replace with register
	--   gs sort
	{
		"echasnovski/mini.operators",
		opts = {
			replace = {
				-- gr is this plugin's default, but that's being used by native LSP stuff now
				-- and I don't want to fight it
				prefix = "gR",
			},
		},
	},
}
