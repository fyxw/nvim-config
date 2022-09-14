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
map('n', ',,', '<cmd>vsp<cr>', {})
map('n', '<leader>[]', '<cmd>tabedit<cr>', {})
map('n', '{', '<cmd>bp<cr>', {})
map('n', '}', '<cmd>bn<cr>', {})
map('n', 'tx', '<cmd>bd<cr>', {})
map('n', 'H', '<c-w>h', {})
map('n', 'I', '<c-w>l', {})

-- Quickly edit the configuration
if vim.fn.has('win64') == 1 then
    map('n', '<leader>fs', '<cmd>tabedit ~/AppData/Local/nvim/lua/plugins.lua<cr>', {})
else
    map('n', '<leader>fs', '<cmd>tabedit ~/.config/nvim/lua/plugins.lua<cr>', {})
end
-- Copy and Past from the system clipboard
map('v', 'Y', '"+y', {})
map('n', 'P', '"+p', {})

-- Some functional configuration
map('n', '<backspace>', '<cmd>noh<cr>', {}) -- cancel highlight that from search
map('n', '-', '@q', {}) -- play the macro 'q'

-- -- NvimTree
-- Open NvimTree
map("n", "<leader>t", "<cmd>NvimTreeToggle<CR>", {});

-- -- Telescope
-- Find file
map("n", "<leader>ff", "<cmd>Telescope find_files theme=dropdown<CR>", {})
-- Find word
map("n", "<leader>fg", "<cmd>Telescope live_grep theme=dropdown<CR>", {})
-- Find special sample
map("n", "<leader>fb", "<cmd>Telescope buffers theme=dropdown<CR>", {})
-- check help doc
map("n", "<leader>fh", "<cmd>Telescope help_tags theme=dropdown<CR>", {})
-- check recent files
map("n", "<leader>fr", "<cmd>Telescope oldfiles theme=dropdown<CR>", {})
-- find marks
map("n", "<leader>fm", "<cmd>Telescope marks theme=dropdown<CR>", {})
