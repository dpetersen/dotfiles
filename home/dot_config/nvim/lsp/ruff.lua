-- Ruff settings to play nice with Pyright
-- https://docs.astral.sh/ruff/editors/setup/#neovim
return {
	on_attach = function(client)
		-- Disable hover in favor of Pyright
		client.server_capabilities.hoverProvider = false
	end,
}
