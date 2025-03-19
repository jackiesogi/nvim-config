local notify = require("notify")

notify.setup({
    --background_colour = "NotifyBackground",
    background_colour = "#2c2e33",
    filter = function(msg, level, opts)
        if msg:match(" lines yanked into ") then
            return false     -- filter out the yank message
        end
        return true
    end,
})


--------------------------------------------------------------------------------
-------------------------          shortcuts           -------------------------
--------------------------------------------------------------------------------
-- Dismiss notifications with Alt-X
vim.keymap.set('n', '<M-X>', function()
    require('notify').dismiss({ silent = true, pending = true })
end, { noremap = true, silent = true })
