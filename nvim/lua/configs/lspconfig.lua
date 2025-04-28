require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "ts_ls", "gopls" }

vim.lsp.enable(servers)
