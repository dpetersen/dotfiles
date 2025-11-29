-- Pyright settings to play nice with Ruff
-- https://docs.astral.sh/ruff/editors/setup/#neovim
return {
	settings = {
		pyright = {
			-- Using Ruff's import organizer
			disableOrganizeImports = true,
		},
	},
}
