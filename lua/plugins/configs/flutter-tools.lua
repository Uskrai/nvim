local lsp = require "plugins.configs.lsp"

require("flutter-tools").setup{
  lsp = {
    on_attach = lsp.on_attach,
    capabilities = lsp.capabilities,
  }
} -- use defaults

