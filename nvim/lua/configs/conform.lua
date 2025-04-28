local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    -- webdev
    javascript = { "biome" },
    javascriptreact = { "biome" },
    typescript = { "biome" },
    typescriptreact = { "biome" },

    css = { "biome" },
    html = { "biome" },
    json = { "biome" },
    jsonc = { "biome" },

    sh = { "shfmt" },
    yaml = { "yamlfmt" },

    go = { "goimports", "gofmt" },

    -- Use the "*" filetype to run formatters on all filetypes.
    ["*"] = { "codespell" },
    -- Use the "_" filetype to run formatters on filetypes that don't
    -- have other formatters configured.
    ["_"] = { "trim_whitespace" },
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

return options
