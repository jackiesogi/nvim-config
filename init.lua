require('config.editor')
require('config.plugins')
require('config.self')

-- Add paths to runtimepath
vim.o.runtimepath = vim.o.runtimepath .. ',~/.local/share/nvim/site/pack/packer/start/packer.nvim'
vim.o.packpath = vim.o.runtimepath

-- Disable Copilot When Starting Neovim
vim.g.copilot_enabled = false
