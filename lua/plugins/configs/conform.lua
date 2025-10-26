local prettier = { "prettierd", "prettier", stop_after_first = true }
require("conform").setup({
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
		toml = { "taplo" },
		python = { "ruff" },
		php = { "pint", "prettierd", "prettier", stop_after_first = true },
	},
})

local function format(context)
	require("conform").format({
		async = true,
		lsp_format = "fallback",
		-- filter = function(client)
		--   if client.name ~= "tsserver" then
		--     return true
		--   end
		--
		--   return false
		-- end,
		timeout_ms = 5000,
	})
end

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>f", format, opts)
