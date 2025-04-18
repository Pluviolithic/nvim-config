require 'diagnostics'
require 'configs'
require 'mappings'
require 'autocmds'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	}
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup 'plugins'
require('gruvbox').setup()
require 'treesitter'

vim.o.background = 'light'
vim.cmd 'colorscheme gruvbox'
vim.api.nvim_set_option('clipboard', 'unnamedplus')
