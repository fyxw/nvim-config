-- Use 'q' to quit from common plugins
vim.api.nvim_create_autocmd({"FileType"}, {
    pattern = {"qf", "help", "man", "lspinfo", "spectre_panel", "lir"},
    callback = function()
        vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR> 
      set nobuflisted 
    ]]
    end
})

-- Remove statusline and tabline when in Alpha
vim.api.nvim_create_autocmd({"User"}, {
    pattern = {"AlphaReady"},
    callback = function()
        vim.cmd [[
      set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
      set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
    ]]
    end
})

-- Set wrap and spell in markdown and gitcommit
vim.api.nvim_create_autocmd({"FileType"}, {
    pattern = {"gitcommit", "markdown"},
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end
})

-- Fixes Autocomment
vim.api.nvim_create_autocmd({"BufWinEnter"}, {
    callback = function()
        vim.cmd "set formatoptions-=cro"
    end
})

-- Highlight Yanked Text
vim.api.nvim_create_autocmd({"TextYankPost"}, {
    callback = function()
        vim.highlight.on_yank {
            higroup = "Visual",
            timeout = 200
        }
    end
})

vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = {"*"},
    callback = function()
        if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
            vim.api.nvim_exec("normal! g'\"", false)
        end
    end
})

vim.api.nvim_create_autocmd({"VimLeave", "VimSuspend"}, {
    callback = function()
        vim.o.guicursor = 'a:ver2'
        -- vim.cmd(':highlight Cursor guibg=white')
    end
    --  command = "set guicursor=a:ver2"   
})

vim.api.nvim_create_autocmd({'BufReadPost','FileReadPost'},{
    pattern = {'*'},
    callback = function()
        vim.cmd('normal zR')
    end
})
