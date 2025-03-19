local neogit = require('neogit')
neogit.setup {}

vim.cmd [[
highlight DiffDelete guifg=#ff0000 ctermfg=red
highlight NeogitDiffDelete guifg=#ff0000 ctermfg=red
highlight NeogitDiffDeleteHighlight guifg=#ff0000 ctermfg=red
]]
