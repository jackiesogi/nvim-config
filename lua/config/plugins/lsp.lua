local lsp = require('lsp-zero')
-- lsp.preset('recommended')

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('user_lsp_attach', { clear = true }),
    callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts)
        vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end, opts)
        vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
    end,
})

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { 
        'clangd',
    },
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({
                capabilities = lsp_capabilities,
            })
        end,
        lua_ls = function()
            require('lspconfig').lua_ls.setup({
                capabilities = lsp_capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT'
                        },
                        diagnostics = {
                            globals = { 'vim' },
                        },
                        workspace = {
                            library = {
                                vim.env.VIMRUNTIME,
                            }
                        }
                    }
                }
            })
        end,
    }
})

-- Disable Copilot's default Tab mapping
vim.g.copilot_no_tab_map = true
--
-- -- Map <M-CR> (Option + Enter) to accept Copilot suggestions
vim.api.nvim_set_keymap('i', '<M-CR>', 'copilot#Accept("<CR>")', { expr=true, noremap = true, silent = true })
-- vim.api.nvim_set_keymap('i', '<Tab>', 'copilot#Accept("<CR>")', { expr=true, noremap = true, silent = true })

local cmp = require('cmp')
local ls = require('luasnip')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

-- this is the function that loads the extra snippets to luasnip
-- from rafamadriz/friendly-snippets
require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
    preselect = cmp.PreselectMode.Item, -- Automatically select the first item
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'luasnip', keyword_length = 2 },
        { name = 'buffer',  keyword_length = 3 },
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-c>'] = cmp.mapping.abort(),
        -- ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),

        ["<Tab>"] = cmp.mapping(function(fallback)
            -- Check if Copilot has a suggestion
            if vim.b._copilot_suggestion ~= nil then
                -- vim.notify("Copilot suggestion: " .. vim.b._copilot_suggestion)
                vim.api.nvim_feedkeys(vim.fn["copilot#Accept"](""), "i", true)
                -- Check if we can jump within a snippet
            elseif ls.locally_jumpable(1) then
                ls.jump(1)
                -- If completion menu is visible, select next item
            -- elseif cmp.visible() then
            --     cmp.select_next_item()
            else
                fallback() -- Default Tab behavior
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif ls.locally_jumpable(-1) then
                ls.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
})


vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '✘',
      [vim.diagnostic.severity.WARN] = '▲',
      [vim.diagnostic.severity.HINT] = '⚑',
      [vim.diagnostic.severity.INFO] = '»',
    },
  },
})

-- Debugging
local dap = require('dap')

-- Make sure CodeLLDB is installed using Mason
require('mason-nvim-dap').setup({
    ensure_installed = { 'codelldb' }, -- Ensures CodeLLDB is installed
    automatic_setup = true,
})

-- TODO: Fix this
-- dap.adapters.gdb = {
--     type = "executable",
--     command = "gdb",
--     args = { "-i", "dap" },
-- }
-- dap.configurations.c = {
--     {
--         name = "Launch",
--         type = "gdb",
--         request = "launch",
--         linux = {
--             MIMode = "gdb",
--             miDebuggerPath = "/usr/bin/gdb"
--         },
--         program = function()
--             return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
--         end,
--         cwd = "/home/jck/Downloads/gitrepo/coreutils/",
--     },
-- }

dap.adapters.codelldb = {
    type = 'server',
    port = "${port}",
    executable = {
        -- Replace with your actual path to codelldb, this works for Mason-installed version
        command = vim.fn.stdpath('data') .. '/mason/packages/codelldb/extension/adapter/codelldb',
        args = { "--port", "${port}" },
    }
}

dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode-14', -- adjust as needed, must be absolute path
  name = 'lldb'
}

dap.configurations.c = {
    {
        name = "Launch C program",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.expand("%:r") .. "-debug" -- Automatically append '-debug' to the current filename
        end,
        args = function()
            local input = vim.fn.input("Arguments: ")
            return vim.split(input, " ")
        end,
        cwd = vim.fn.getcwd(),
        stopOnEntry = false,
        runInTerminal = true, 
    },
}

lsp.setup()
