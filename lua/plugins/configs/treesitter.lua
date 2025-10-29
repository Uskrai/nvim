-- local parser = require("nvim-treesitter.parsers").get_parser_configs()
-- parser.dart = {
-- 	-- https://github.com/nvim-treesitter/nvim-treesitter/issues/4945
-- 	install_info = {
-- 		url = "https://github.com/UserNobody14/tree-sitter-dart",
-- 		files = { "src/parser.c", "src/scanner.c" },
-- 		revision = "8aa8ab977647da2d4dcfb8c4726341bee26fbce4", -- The last commit before the snail speed
-- 	},
-- }

require("nvim-treesitter").install({
	"rust",
	"dart",
	"lua",
	"tsx",
	"javascript",
	"typescript",
	"html",
	"css",
	"java",
	"gitcommit",
	"gitignore",
	"git_config",
	"git_rebase",
	"ssh_config",
	"http",
	"zig",
	"diff",
	"json",
	"json5",
	"fish",
	"bash",
	"nu",
	"toml",
	"yaml",
	"csv",
	"php",
	"blade",
	"phpdoc",
	"ini",
	"dot",
	"make",
})

vim.api.nvim_create_autocmd("FileType", {
	desc = "User: enable treesitter highlighting",
	callback = function(ctx)
		-- highlights
		local hasStarted = pcall(vim.treesitter.start, ctx.buf) -- errors for filetypes with no parser

		-- indent
		local dontUseTreesitterIndent = {}
		if hasStarted and not vim.list_contains(dontUseTreesitterIndent, ctx.match) then
			vim.bo[ctx.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end,
})

require("nvim-treesitter").setup({
	install_dir = vim.fn.stdpath("data") .. "/tree-sitter",
	playground = {
		enable = true,
		disable = {},
		updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
		persist_queries = false, -- Whether the query persists across vim sessions
		keybindings = {
			toggle_query_editor = "o",
			toggle_hl_groups = "i",
			toggle_injected_languages = "t",
			toggle_anonymous_nodes = "a",
			toggle_language_display = "I",
			focus_language = "f",
			unfocus_language = "F",
			update = "R",
			goto_node = "<cr>",
			show_help = "?",
		},
	},

	highlight = {
		enable = true,
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
		-- disable = { 'php' }
	},
})

-- vim.g.rainbow_delimiters = {
--   strategy = {
--     [''] = rainbow_delimiters.strategy['global'],
--     vim = rainbow_delimiters.strategy['local'],
--   },
--   query = {
--     [''] = 'rainbow-delimiters',
--     lua = 'rainbow-blocks',
--   },
--   highlight = {
--     'RainbowDelimiterRed',
--     'RainbowDelimiterYellow',
--     'RainbowDelimiterBlue',
--     'RainbowDelimiterOrange',
--     'RainbowDelimiterGreen',
--     'RainbowDelimiterViolet',
--     'RainbowDelimiterCyan',
--   },
-- }
