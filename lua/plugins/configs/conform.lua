
local prettier = { "prettierd", "prettier", stop_after_first = true },

require("conform").setup {
    formatters_by_ft = {
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        -- python = { "isort", "black" },
        -- Use a sub-list to run only the first available formatter
        javascript = prettier,
        typescript = prettier,
        jsx = prettier,
        tsx = prettier,
        xml = { "xmllint" },
        rust = { "rustfmt" },
        toml = {  "taplo"  },
        python = {  "ruff"  },
        php = { "pint", "prettier", stop_after_first = true }
    },
}
