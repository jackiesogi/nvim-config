require('config.editor')
require('config.plugins')

-- Add paths to runtimepath
vim.o.runtimepath = vim.o.runtimepath .. ',~/.local/share/nvim/site/pack/packer/start/packer.nvim'
vim.o.packpath = vim.o.runtimepath
