-- Preserve the fat cursor
vim.opt.guicursor = ""
vim.opt.cursorline = true
-- vim.api.nvim_set_hl(0, 'CursorLine', {}) -- Default
vim.api.nvim_set_hl(0, 'CursorLine', { underline = true, bg = 'none' })

-- Line numbers and relativenumber
vim.opt.number = true
vim.opt.relativenumber = true

-- 4 spaces indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

-- No Line Wrap
vim.opt.wrap = false

-- History and Backup
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Incremental search
-- vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append { "@-@" }

-- Set the timeoutlen
vim.opt.updatetime = 150

-- Set the colorcolumn
vim.opt.colorcolumn = ""

-- Set leader key
vim.g.mapleader = " "

vim.opt.list = true
vim.opt.listchars = {
    tab = '▸ ',
    eol = '↴',
    trail = '•',
    extends = '…',
    precedes = '…',
    nbsp = '␣',
}

vim.opt.foldenable = true
-- vim.opt.foldlevel = 20
-- vim.opt.wrap = true;
