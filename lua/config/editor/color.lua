function ColorMyPencils()
    vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
end

ColorMyPencils()

vim.opt.incsearch = true
vim.opt.hlsearch = true

vim.api.nvim_create_autocmd("CmdlineEnter", {
  pattern = "/,?",
  callback = function()
    vim.opt.hlsearch = true
  end,
})

-- Entering to insert mode will turn off highlighting
vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    vim.opt.hlsearch = false
  end,
})

