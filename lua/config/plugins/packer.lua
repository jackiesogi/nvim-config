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
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }

    use('theprimeagen/harpoon')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')

    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    })

    use('vim-airline/vim-airline')
    use('vim-airline/vim-airline-themes')

    -- LSP Requirements
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            'neovim/nvim-lspconfig',
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- Autocompletion
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip',
            'L3MON4D3/LuaSnip',
            'rafamadriz/friendly-snippets'
        }
    }

    -- Git Integration
    use 'NeogitOrg/neogit'

    -- Better Command Prompt
    use('folke/noice.nvim')

    use('MunifTanjim/nui.nvim')
    use('rcarriga/nvim-notify')

    -- Code Outline
    use 'simrat39/symbols-outline.nvim'

    -- Debug
    use {
        'nvim-neotest/nvim-nio', -- Add this line
        config = function()
            -- Any configuration you want to add for nvim-nio
        end
    }
    use {
        'mfussenegger/nvim-dap',
        tag = '0.9.0',
        requires = {
            'rcarriga/nvim-dap-ui',
            'jay-babu/mason-nvim-dap.nvim',
            'nvim-neotest/nvim-nio',
        },
        config = function()
            require("config.plugins.dap")
        end
    }

    -- Comment
    use {
        'numToStr/Comment.nvim',
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
        use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
        use 'nvim-lua/plenary.nvim'
        use 'theprimeagen/harpoon'
        use 'mbbill/undotree'
        use 'tpope/vim-fugitive'

        -- UI & UX optimization
        use 'vim-airline/vim-airline'
        use 'vim-airline/vim-airline-themes'
        use 'rcarriga/nvim-notify'
        use 'MunifTanjim/nui.nvim'
        use 'folke/noice.nvim'

        -- LSP and Autocompletion
        use { 'VonHeikemen/lsp-zero.nvim', requires = {
            'neovim/nvim-lspconfig',
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
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
