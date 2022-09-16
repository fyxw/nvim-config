local autocmd = vim.api.nvim_create_autocmd

-- Use 'q' to quit from common plugins
autocmd({"FileType"}, {
    desc = "Use 'q' to quit from common plugins",
    pattern = {"qf", "help", "man", "lspinfo", "spectre_panel", "lir"},
    callback = function()
        vim.opt.buflisted = false
        vim.keymap.set('n', 'q', '<cmd>close<CR>', { buffer = true })
    end
})

-- Remove statusline and tabline when in Alpha
autocmd({"User"}, {
    desc = 'Remove statusline and tabline when in Alpha',
    pattern = {"AlphaReady"},
    callback = function()
        vim.opt.showtabline = 0
        vim.opt.laststatus = 0
        autocmd({'BufUnload'},{
            pattern = '<buffer>',
            callback = function ()
                vim.opt.showtabline = 2
                vim.opt.laststatus = 3
            end
        })
    end
})
-- Set wrap and spell in markdown and gitcommit
autocmd({"FileType"}, {
    desc = 'Set wrap and spell in markdown and gitcommit',
    pattern = {"gitcommit", "markdown"},
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end
})

-- Fixes Autocomment
autocmd({"BufWinEnter"}, {
    desc = 'Fixes Autocomment, set formatoptions-=cro',
    callback = function()
        vim.cmd "set formatoptions-=cro"
    end
})

-- Highlight Yanked Text
autocmd({"TextYankPost"}, {
    desc = 'Highlight Yanked Text',
    callback = function()
        vim.highlight.on_yank {
            higroup = "Visual",
            timeout = 200
        }
    end
})

-- zsh highlight
autocmd("FileType", {
    desc = 'zsh highlight',
    pattern = "zsh",
    callback = function()
        -- let treesitter use bash highlight for zsh files as well
        require("nvim-treesitter.highlight").attach(0, "bash")
    end,
})

-- autocmd("BufReadPost", {
--     pattern = {"*"},
--     callback = function()
--         if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
--             vim.api.nvim_exec("normal! g'\"", false)
--         end
--     end
-- })

autocmd({"VimLeave", "VimSuspend"}, {
    desc = 'resume cursor when leave neovim',
    callback = function()
        vim.o.guicursor = 'a:ver2'
        -- vim.cmd(':highlight Cursor guibg=white')
    end
    --  command = "set guicursor=a:ver2"   
})

