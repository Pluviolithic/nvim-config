return function()
	require('luau-lsp').setup {
		sourcemap = {
			enabled = true,
			autogenerate = true, -- automatic generation when the server is attached
			rojo_project_file = 'default.project.json',
		},
		types = {
			roblox = true,
		},
	}
end
