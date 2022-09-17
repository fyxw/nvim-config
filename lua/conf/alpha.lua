-- require'alpha'.setup(require'alpha.themes.dashboard'.config)
local dashboard = require('alpha.themes.dashboard')

local plugins = '~/.config/nvim/lua/plugins.lua'
if vim.fn.has('win64') == 1 then
    plugins = '~/AppData/Local/nvim/lua/plugins.lua<cr>'
end

dashboard.section.buttons.val = {
  dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
  dashboard.button("e", " " .. " New file", ":ene <BAR> startinsert <CR>"),
  -- dashboard.button("p", " " .. " Find project", ":lua require('telescope').extensions.projects.projects()<CR>"),
  dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
  dashboard.button("t", " " .. " Find text", ":Telescope live_grep <CR>"),
  dashboard.button("c", " " .. " Plugins", ":e " .. plugins .. " <CR>"),
  dashboard.button("q", " " .. " Quit", ":qa<CR>"),
}

require('alpha').setup(dashboard.config)
