local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()
-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
    return
end
return packer.startup({
    function(use)
        use 'wbthomason/packer.nvim'
        -- My plugins here
        -- Is using a standard Neovim install, i.e. built from source or using a
        -- provided appimage.
        use 'lewis6991/impatient.nvim'
        local cmp_sources = {"hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-nvim-lua", "hrsh7th/cmp-nvim-lsp",
                             "saadparwaiz1/cmp_luasnip","L3MON4D3/LuaSnip"}
        use {
            "hrsh7th/nvim-cmp",
            config = function()
                require 'conf.cmp'
            end,
            requires = cmp_sources
        }

        -- Treesitter
        if vim.fn.has 'unix' == 1 then
            use {
                'nvim-treesitter/nvim-treesitter',
                run = ':TSUpdate',
                requires = {'nvim-treesitter/playground', 'nvim-treesitter/nvim-treesitter-textobjects',
                            'p00f/nvim-ts-rainbow', 'JoosepAlviste/nvim-ts-context-commentstring',
                            'windwp/nvim-ts-autotag'},
                config = function ()
                    require('conf.treesitter')
                end
            }
        end
        use {'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim', 'neovim/nvim-lspconfig'}
        -- Dashboard
        use {
            'goolord/alpha-nvim',
            requires = {'kyazdani42/nvim-web-devicons'},
            config = function()
                require 'conf.alpha'
            end
        }
        -- Comment plugin
        use {
            'numToStr/Comment.nvim',
            config = function()
                require('Comment').setup {}
            end
        }

        -- ui statusline
        use({
            'NTBBloodbath/galaxyline.nvim',
            -- your statusline
            config = function()
                require('galaxyline.themes.eviline')
            end,
            -- some optional icons
            requires = {
                'kyazdani42/nvim-web-devicons',
                opt = true
            }
        })
        -- bufferline
        use {
            'akinsho/bufferline.nvim',
            tag = 'v2.*',
            requires = {'kyazdani42/nvim-web-devicons'},
            config = function()
                require('bufferline').setup {}
            end
        }

        -- Dirctory Tree
        use {
            'kyazdani42/nvim-tree.lua',
            requires = {'kyazdani42/nvim-web-devicons' -- optional, for file icon
            },
            tag = 'nightly', -- optional, updated every week. (see issue #1193)
            config = function()
                require('nvim-tree').setup {}
            end
        }
        use {
            'nvim-telescope/telescope.nvim',
            requires = {'nvim-lua/plenary.nvim' -- Lua 开发模块
            },
            config = function()
                require('telescope').setup {}
            end
        }
        use {
            'folke/which-key.nvim',
            config = function()
                require('conf.which-key')
            end
        }

        -- Colorschemes
        use({
            'NTBBloodbath/doom-one.nvim',
            setup = function()
                -- Add color to cursor
                vim.g.doom_one_cursor_coloring = false
                -- Set :terminal colors
                vim.g.doom_one_terminal_colors = true
                -- Enable italic comments
                vim.g.doom_one_italic_comments = false
                -- Enable TS support
                vim.g.doom_one_enable_treesitter = true
                -- Color whole diagnostic text or only underline
                vim.g.doom_one_diagnostics_text_color = false
                -- Enable transparent background
                vim.g.doom_one_transparent_background = false

                -- Pumblend transparency
                vim.g.doom_one_pumblend_enable = false
                vim.g.doom_one_pumblend_transparency = 20

                -- Plugins integration
                vim.g.doom_one_plugin_neorg = true
                vim.g.doom_one_plugin_barbar = false
                vim.g.doom_one_plugin_telescope = false
                vim.g.doom_one_plugin_neogit = true
                vim.g.doom_one_plugin_nvim_tree = true
                vim.g.doom_one_plugin_dashboard = true
                vim.g.doom_one_plugin_startify = true
                vim.g.doom_one_plugin_whichkey = true
                vim.g.doom_one_plugin_indent_blankline = true
                vim.g.doom_one_plugin_vim_illuminate = true
                vim.g.doom_one_plugin_lspsaga = false
            end,
            config = function()
                vim.cmd('colorscheme doom-one')
            end
        })

        -- Automatically set up your configuration after cloning packer.nvim
        -- Put this at the end after all plugins
        if packer_bootstrap then
            require('packer').sync()
        end
    end,
    config = {
        display = {
            open_fn = require('packer.util').float
        }
    }
})
