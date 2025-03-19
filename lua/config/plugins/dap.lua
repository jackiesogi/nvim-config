local dap = require("dap")
local dapui = require("dapui")

dap.set_log_level("TRACE")

dapui.setup({
    icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
    mappings = {
        expand = { "<CR>", "<2-LeftMouse>" },
        open = {},
        remove = {},
        edit = {},
        repl = {},
        toggle = {},
        view_breakpoints = {},
    },
    expand_lines = vim.fn.has("nvim-0.7"),
    layouts = {
        {
            elements = {
                { id = "scopes", size = 0.66 },
                { id = "watches", size = 0.33 },
            },
            size = 0.35,
            position = "left",
        },
        {
            elements = {
                "stacks",
                { id = "repl", size = 0.4 },
            },
            size = 0.25,
            position = "bottom",
        },
    },
    floating = {
        max_height = nil,
        max_width = nil,
        border = "single",
        mappings = {
            close = { "q", "<Esc>" },
        },
    },
    windows = { indent = 1 },
    render = {
        max_type_length = nil,
        max_value_lines = 100,
    },
})

local original_scrolloff = vim.o.scrolloff

dap.listeners.after.event_initialized['set_scrolloff'] = function()
    vim.o.scrolloff = 22
end

dap.listeners.before.event_terminated['restore_scrolloff'] = function()
    vim.o.scrolloff = original_scrolloff
end

dap.listeners.before.event_exited['restore_scrolloff'] = function()
    vim.o.scrolloff = original_scrolloff
end

dap.listeners.after.event_initialized['dapui_config'] = function()
    dapui.open()
end

dap.listeners.before.event_terminated['dapui_config'] = function()
    dapui.close()
end

dap.listeners.before.event_exited['dapui_config'] = function()
    dapui.close()
end

local function run_dap()
    local input = vim.fn.input("Executable and Arguments: ")
    local parts = vim.split(input, " ")
    local program = parts[1]
    table.remove(parts, 1)
    require'dap'.run({
        type = "codelldb",  -- Change to "lldb" if needed
        request = "launch",
        name = "Launch C program",
        runInTerminal = true,
        program = program,
        args = parts,
        cwd = vim.fn.getcwd(),
        stopOnEntry = false,
    })
end

-- Function to prompt the user for an executable and arguments, then launch gdb in a vertical split terminal
local function debug_gdb()
    local user_input = vim.fn.input('Executable and arguments: ')
    if user_input ~= "" then
        vim.cmd('vs | wincmd l | terminal gdb --args ' .. user_input)
    else
        print('No input provided.')
    end
end

-- Key mappings for debugging
-- Run DAP
vim.keymap.set('n', '<leader>dr', run_dap, { noremap = true, silent = true })

-- continue
vim.keymap.set('n', '<leader>dc', function() require'dap'.continue() end, { noremap = true, silent = true })

-- next
vim.keymap.set('n', '<leader>dn', function() require'dap'.step_over() end, { noremap = true, silent = true })

-- step into
vim.keymap.set('n', '<leader>ds', function() require'dap'.step_into() end, { noremap = true, silent = true })

-- step out
vim.keymap.set('n', '<leader>df', function() require'dap'.step_out() end, { noremap = true, silent = true })

-- toggle breakpoint
vim.keymap.set('n', '<leader>b', function() require'dap'.toggle_breakpoint() end, { noremap = true, silent = true })

-- set conditional breakpoint
vim.keymap.set('n', '<leader>B', function() require'dap'.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, { noremap = true, silent = true })

-- set log point
vim.keymap.set('n', '<leader>lp', function() require'dap'.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end, { noremap = true, silent = true })

-- toggle DAP UI
vim.keymap.set('n', '<leader>dt', function() require'dapui'.toggle() end, { noremap = true, silent = true })

-- Start GDB debugging
vim.keymap.set('n', '<leader>db', debug_gdb, { noremap = true, silent = true })
