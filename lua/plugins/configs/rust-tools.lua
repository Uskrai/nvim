local lsp = require "plugins.configs.lsp"

local last_ra = nil

vim.g.rustaceanvim = {
  server = {
    on_attach = lsp.on_attach,
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

    root_dir = function(fname, default_root_dir)
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
}
