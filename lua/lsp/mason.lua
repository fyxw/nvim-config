require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require("mason-lspconfig").setup({
    ensure_installed = {"sumneko_lua"}
})
local lspconfig = require("lspconfig")

local servers = {"sumneko_lua", "jdtls", "bashls", "jsonls", "yamlls"}

for _, server in pairs(servers) do
    opts = {
        on_attach = require("lsp.handlers").on_attach,
        capabilities = require("lsp.handlers").capabilities
    }

    if server == "sumneko_lua" then
        local sumneko_opts = require "lsp.settings.sumneko_lua"
        opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    end

    lspconfig[server].setup(opts)
end
