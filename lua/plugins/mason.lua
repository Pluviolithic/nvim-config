return {
	'williamboman/mason.nvim',
	dependencies = {
		{ 'williamboman/mason-lspconfig.nvim' },
		{ 'VonHeikemen/lsp-zero.nvim', branch = 'v3.x' },
		{ 'neovim/nvim-lspconfig' },
	},
	config = function()
		local lsp_zero = require 'lsp-zero'

		lsp_zero.on_attach(function(_, bufnr)
			-- see :help lsp-zero-keybindings
			-- to learn the available actions
			lsp_zero.default_keymaps { buffer = bufnr }
		end)

		require('mason').setup()
		require('mason-lspconfig').setup {
			ensure_installed = { 'luau_lsp' },
			handlers = {
				lsp_zero.default_setup,
			},
		}
		require('mason-lspconfig').setup_handlers {
			luau_lsp = require 'lsp.luau',
		}
	end,
}
