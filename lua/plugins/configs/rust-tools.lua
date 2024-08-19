local lsp = require "plugins.configs.lsp"

local rt = require("rust-tools")

local default_root_dir = require "lspconfig.server_configurations.rust_analyzer".default_config.root_dir

local last_ra = nil

rt.setup({
  server = {
    on_attach = lsp.on_attach_without_inlay,
    capabilities = lsp.capabilities,
    flags = lsp.flags,
    -- cmd = { "ra-multiplex" },
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
        },
        checkOnSave = {
          command = "clippy"
        }
      }
    },

    root_dir = function(fname)
      local is_cargo = vim.fn.match(fname, os.getenv("CARGO_HOME")) ~= -1
      local is_toolchain = vim.fn.match(fname, os.getenv("RUSTUP_HOME")) ~= -1

      local is_readonly = is_cargo or is_toolchain

      if is_readonly and last_ra ~= nil then
        return last_ra
      elseif is_readonly then
        return default_root_dir(fname)
      else
        last_ra = default_root_dir(fname)
        return last_ra
      end

    end
  },
})
