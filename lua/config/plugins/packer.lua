-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

-- Set Verbose Mode
-- vim.cmd("set verbosefile=$HOME/.config/nvim/verbose.log")
-- vim.cmd("set verbose=2")


return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }

    use{'theprimeagen/harpoon', commit = '1bc17e3'}
    use{'mbbill/undotree', commit = 'b951b87'}
    use{'tpope/vim-fugitive', commit = '4a745ea'}

    use({
        "kylechui/nvim-surround",
        tag = "*",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    })

    use{'vim-airline/vim-airline', commit = '45003f9'}
    use{'vim-airline/vim-airline-themes', commit = 'cda3b5e'}

    -- LSP Requirements
    use {
        'VonHeikemen/lsp-zero.nvim',
        commit = '2afa32e',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig', commit = 'e39da6a'},
            {'williamboman/mason.nvim', commit = 'fc98833'},
            {'williamboman/mason-lspconfig.nvim', commit = '1a31f82'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp', commit = 'b53311ab'},
            {'hrsh7th/cmp-nvim-lsp', commit = 'a8912b8'},
            {'hrsh7th/cmp-buffer', commit = 'b74fab3'},
            {'hrsh7th/cmp-path', commit = 'c6635aa'},
            {'saadparwaiz1/cmp_luasnip'},
            {'L3MON4D3/LuaSnip', commit = 'c9b9a22'},
            {'rafamadriz/friendly-snippets', commit = '31f2a26'}
        }
    }

    -- Git Integration
    use{'NeogitOrg/neogit', commit = '97f83f1'}

    -- Better Command Prompt
    use{'folke/noice.nvim', commit = '0427460'}

    use{'MunifTanjim/nui.nvim', commit = '8d3bce9'}
    use{'rcarriga/nvim-notify', commit = 'b5825cf'}

    -- Code Outline
    use{'simrat39/symbols-outline.nvim', commit = '564ee65'}

    -- Debug
    use {
        'nvim-neotest/nvim-nio', -- Add this line
        commit = '21f5324',
        config = function()
        end
    }
    use {
        'mfussenegger/nvim-dap',
        tag = '0.9.0',
        requires = {
            {'rcarriga/nvim-dap-ui', commit = '881a69e'},
            {'jay-babu/mason-nvim-dap.nvim', commit = '4c2cdc6'},
            {'nvim-neotest/nvim-nio', commit = '21f5324'},
        },
        config = function()
            require("config.plugins.dap")
        end
    }

    -- Comment
    use {
        'numToStr/Comment.nvim',
        commit = 'e30b7f2',
        config = function()
            require('Comment').setup()
        end
    }

    --use({'VonHeikemen/lsp-zero.nvim', branch = 'v4.x'})
    --use({'neovim/nvim-lspconfig'})
    --use({'hrsh7th/nvim-cmp'})
    --use({'hrsh7th/cmp-nvim-lsp'})

    -- packer.lua: Plugin Management
    vim.cmd [[packadd packer.nvim]]

    return require('packer').startup(function(use)
        -- Packer should manage itself
        use 'wbthomason/packer.nvim'

        -- Basic features
        use { 'nvim-treesitter/nvim-treesitter', commit = '7bbed4b', run = ':TSUpdate' }
        use {'nvim-lua/plenary.nvim', commit = '857c5ac'}
        use {'theprimeagen/harpoon'}
        use {'mbbill/undotree'}
        use {'tpope/vim-fugitive'}

        -- UI & UX optimization
        use {'vim-airline/vim-airline'}
        use {'vim-airline/vim-airline-themes'}
        use {'rcarriga/nvim-notify'}
        use {'MunifTanjim/nui.nvim'}
        use {'folke/noice.nvim'}

        -- LSP and Autocompletion
        use { 'VonHeikemen/lsp-zero.nvim', requires = {
            'neovim/nvim-lspconfig',
            'williamboman/mason.nvim',
            {'williamboman/mason-lspconfig.nvim', commit = '1a31f82'},
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip',
            'L3MON4D3/LuaSnip',
            'rafamadriz/friendly-snippets'
        } }

        -- Debugging (DAP)
        use { 'mfussenegger/nvim-dap', requires = {
            'rcarriga/nvim-dap-ui',
            'jay-babu/mason-nvim-dap.nvim',
            'nvim-neotest/nvim-nio',
        } }

        -- Telescope (Fuzzy Finder)
        use { 'nvim-telescope/telescope.nvim', tag = '0.1.8', requires = { 'nvim-lua/plenary.nvim' } }

        -- Git
        use 'NeogitOrg/neogit'

        -- Autopairs
        use { "windwp/nvim-autopairs" }

        -- Comment
        use { 'numToStr/Comment.nvim' }

        -- symbols-outline
        use 'simrat39/symbols-outline.nvim'


        use({
            'nvimdev/lspsaga.nvim',
            commit = '778d56f',
            after = 'nvim-lspconfig',
            config = function()
                require('lspsaga').setup({
                    finder = {
                        max_height = 0.7,
                        layout = 'normal',
                    }
                })
            end,
        })

        use {
            'rose-pine/neovim',
            as = 'rose-pine',
            config = function()
                vim.cmd('colorscheme rose-pine')
                vim.api.nvim_set_hl(0, 'CursorLine', { underline = true })
            end
        }

        -- flash.nvim
        use { 'folke/flash.nvim' }
    end)
end)
