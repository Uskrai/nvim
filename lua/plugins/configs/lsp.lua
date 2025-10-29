-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- local lsp_formatting = function(bufnr)
--
-- end

local on_attach_without_inlay = function(_, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	local function code_action(context)
		vim.lsp.buf.code_action({
			filter = function(c)
				return true
			end,
		})
	end

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", ":Telescope lsp_definitions<cr>", bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", ":Telescope lsp_implementations<cr>", bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<leader>a", code_action, bufopts)
	-- vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", ":Telescope lsp_references<cr>", bufopts)
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	on_attach_without_inlay(client, bufnr)
	vim.lsp.inlay_hint.enable(true)
end

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
		on_attach(client, ev.buf)
	end,
})

local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 150,
}

local capabilities = require("cmp_nvim_lsp").default_capabilities()

capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), capabilities, {
	workspace = {
		didChangeWatchedFiles = {
			dynamicRegistration = false,
		},
	},
})
-- local capabilities = require"coq".lsp_ensure_capabilities(vim.lsp.protocol.make_client_capabilities())

local lspconfig = require("lspconfig")

-- require('lspconfig')['pyright'].setup {
--   on_attach = on_attach,
--   flags = lsp_flags,
--   capabilities = capabilities,
-- }

vim.lsp.config("*", {
	-- on_attach = on_attach,
	capabilities = capabilities,
	flags = lsp_flags,
})

vim.lsp.enable("pylsp")
vim.lsp.enable("ruff")
vim.lsp.enable("eslint")
vim.lsp.enable("clangd")
vim.lsp.enable("zls")
vim.lsp.enable("gopls")
vim.lsp.enable("html")
vim.lsp.enable("cssls")
vim.lsp.enable("dockerls")
vim.lsp.enable("jdtls")
vim.lsp.enable("csharp_ls")
vim.lsp.enable("dartls")

vim.lsp.enable("intelephense")
vim.lsp.config("intelephense", {
	init_options = {
		licenceKey = "CodeCodeCodeCode",
	},
})

vim.lsp.enable("lua_ls")
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

vim.lsp.enable("ts_ls")
vim.lsp.config("ts_ls", {

	-- root_dir = require("lspconfig").util.root_pattern("package.json"),
	single_file_support = false,
})

vim.lsp.enable("ts_ls")
vim.lsp.config("denols", {
	root_dir = require("lspconfig").util.root_pattern("deno.json"),
})

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)

-- vim.diagnostic.config({
--   virtual_text = false,
--   -- virtual_lines = {
--   --   only_current_line = true
--   -- }
-- })
-- require("lsp_lines").setup()
-- local function enable_lsp_lines()
--   vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines })
--   print(require("lsp_lines").toggle())
--   print("toggle lsp_lines")
-- end
--
-- vim.keymap.set(
--   "",
--   "<Leader>l",
--   enable_lsp_lines,
--   { desc = "Toggle lsp_lines" }
-- )

-- require("flutter-tools").setup{
--   lsp = {
--     on_attach = on_attach,
--     capabilities = capabilities,
--   }
-- } -- use defaults

local last_ra = nil

vim.g.rustaceanvim = {
	server = {
		on_attach = on_attach,
		capabilities = capabilities,
		-- cmd = { "ra-multiplex" },
		settings = {
			["rust-analyzer"] = {
				cargo = {
					allFeatures = true,
				},
				checkOnSave = {
					command = "clippy",
				},
			},
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
		end,
	},
}

return {
	on_attach = on_attach,
	on_attach_without_inlay = on_attach_without_inlay,
	flags = lsp_flags,
	capabilities = capabilities,
}
