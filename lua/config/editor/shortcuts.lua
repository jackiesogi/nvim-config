local opts = { noremap = true, silent = true }


-- Ctrl + s to save
vim.keymap.set({'n', 'i'}, '<C-s>', vim.cmd.w)

--------------------------------------------------------------------------------
--------------------------          macro            ---------------------------
--------------------------------------------------------------------------------
-- Execute macro @a with <leader><leader>
vim.keymap.set('n', '<Leader><Leader>', '@a', opts)


--------------------------------------------------------------------------------
-------------------------       copy and paste       ---------------------------
--------------------------------------------------------------------------------
-- Overwrite the original p keyboard shortcut
vim.keymap.set('x', 'p', [["_dP]], opts)

-- Faster yank & cut to system clipboard
vim.keymap.set('v', '<leader>y', '"+y', opts)

-- 
vim.keymap.set('v', '<leader>x', '"+x', opts)

-- -- Symbols outline
-- vim.keymap.set('n', '<leader>o', ':SymbolsOutline<CR>')
--
--
-- -- Dismiss notifications with Alt-X
-- vim.keymap.set('n', '<M-X>', function()
--     require('notify').dismiss({ silent = true, pending = true })
-- end, opts)

--------------------------------------------------------------------------------
-------------------------         quick actions         ------------------------
--------------------------------------------------------------------------------

-- Quickfix action
local function quickfix()
    vim.lsp.buf.code_action({
        filter = function(a) return a.isPreferred end,
        apply = true
    })
end

-- Quickfix
vim.keymap.set('n', '<leader>qf', quickfix, opts)

-- Quick replace
vim.keymap.set('n', '<leader>s', ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/g<Left><Left>")

-- Toggle true and false
function ToggleBoolean()
    local word = vim.fn.expand("<cword>")
    if word == "true" then
        vim.cmd('normal! ciwfalse')
    elseif word == "false" then
        vim.cmd('normal! ciwtrue')
    end
end

vim.keymap.set('n', '<C-t>', ToggleBoolean, { noremap = true, silent = true })

-- Format code
function CodeFormat()
    vim.lsp.buf.format()
end

vim.keymap.set('n', '<leader>fm', function() CodeFormat() end)


--------------------------------------------------------------------------------
-------------------------            others             ------------------------
--------------------------------------------------------------------------------
-- Automatically clear search highlighting after pressing <Enter>
vim.api.nvim_create_autocmd("CmdlineLeave", {
    pattern = { "/", "?" },
    command = "noh"
})

-- Restore Ctrl-X for decrementing numbers
vim.keymap.set('n', '<C-X>', '<C-X>', opts)

--------------------------------------------------------------------------------
---------------------------       tabs & panels      ---------------------------
--------------------------------------------------------------------------------
-- Open a new tab with a terminal
-- vim.keymap.set('n', '<leader>t', ':tabnew | term<CR>', opts)

-- Switch to next tab
vim.keymap.set('n', '<Tab>', ':tabnext<CR>', opts)

-- Switch to previous tab
vim.keymap.set('n', '<S-Tab>', ':tabprevious<CR>', opts)

-- Escape terminal mode with <Esc>
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', opts)

-- Move between panels
vim.keymap.set('n', '<Leader>ww', '<C-w>w', opts)

-- Remap :vs to auto move right
vim.keymap.set('c', 'vs', 'vs | wincmd l', opts)

-- Exit to netrw screen
vim.keymap.set('n', '<leader>ex', vim.cmd.Rex)
