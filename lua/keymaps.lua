local function map(mode, lhs, rhs, opts)
    local options = {
        noremap = true
    }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Vim for Colemak
vim.g.mapleader = ' '
-- Shortcut for quiting and saving
map('', 'Q', ':q<cr>', {})
map('', 'S', ':w<cr>', {})

-- About buffers
map('n', '<leader>|', '<cmd>vsp<cr>', {})
map('n', '<leader>[]', '<cmd>tabedit<cr>', { desc = 'edit' })
map('n', '{', '<cmd>bp<cr>', {})
map('n', '}', '<cmd>bn<cr>', {})
map('n', 'tx', '<cmd>bd<cr>', {})
map('n', 'H', '<c-w>h', {})
map('n', 'L', '<c-w>l', {})

-- Quickly edit the configuration
local opts = { desc = 'edit plugins.lua' }
if vim.fn.has('win64') == 1 then
    map('n', '<leader>fs', '<cmd>tabedit ~/AppData/Local/nvim/lua/plugins.lua<cr>', opts)
else
    map('n', '<leader>fs', '<cmd>tabedit ~/.config/nvim/lua/plugins.lua<cr>', opts)
end
-- Copy and Past from the system clipboard
map('v', 'Y', '"+y', {})
map('n', 'P', '"+p', {})

-- Some functional configuration
map('n', '<backspace>', '<cmd>noh<cr>', { desc = 'cancel highlight'}) -- cancel highlight that from search
map('n', '-', '@q', {}) -- play the macro 'q'

-- -- NvimTree
-- Open NvimTree
map("n", "<leader>t", "<cmd>NvimTreeToggle<CR>", {});

-- -- Telescope
-- Find file
map("n", "<leader>ff", "<cmd>Telescope find_files theme=dropdown<CR>", { desc = 'find file'})
-- Find word
map("n", "<leader>fg", "<cmd>Telescope live_grep theme=dropdown<CR>", { desc = 'find word'})
-- Find special sample
map("n", "<leader>fb", "<cmd>Telescope buffers theme=dropdown<CR>", { desc = 'find buffers'})
-- check help doc
map("n", "<leader>fh", "<cmd>Telescope help_tags theme=dropdown<CR>", { desc = 'check help doc'})
-- check recent files
map("n", "<leader>fr", "<cmd>Telescope oldfiles theme=dropdown<CR>", { desc = 'check old files' })
-- find marks
map("n", "<leader>fm", "<cmd>Telescope marks theme=dropdown<CR>", { desc = 'find marks'})

-- -- Dashboard
map("n", "<leader>;", "<cmd>Alpha<CR>",{ desc = 'Dashboard'})

local status_ok, wk = pcall(require, "which-key")
if not status_ok then
    return
end
wk.register({
    ['<leader>f'] = { name = "+file"},
    ['<leader>l'] = { name = '+lsp'}
})
