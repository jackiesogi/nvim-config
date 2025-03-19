local builtin = require('telescope.builtin')
local noice = require("noice")

-- Define a function to show the grep prompt with Noice
local function noice_grep_string()
    -- local input = vim.fn.input('Grep > ')
    local input = vim.fn.input('Project Search >')
    if input ~= "" then
        -- Use Noice to display an informational message (like a notification)
        noice.notify({
            kind = "info", -- Type of notification
            title = "Project Grep", -- Title for the notification
            message = "Searching for: " .. input, -- Message content
            icon = "🔍", -- Icon for the notification
        })
        -- Now call Telescope's grep_string with the input
        builtin.grep_string({ search = input })
    end
end

-- Set up key mappings
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>fs', noice_grep_string, {})
