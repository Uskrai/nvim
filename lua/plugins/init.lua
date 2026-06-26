-- Only if your version of Neovim doesn't have https://github.com/neovim/neovim/pull/12632 merged
-- vim.cmd "packadd packer.nvim"

local treesitter_cmds = {
	"TSInstall",
	"TSBufEnable",
	"TSBufDisable",
	"TSEnable",
	"TSDisable",
	"TSModuleInfo",
}

local lazy_load = require("lazy_load")

local on_file_open = { "BufRead", "BufNewFile" }

-- local function on_file_open
--     return {
--         "BufRead", "BufNewFile",
--     }
-- end
--
local function load_config(name)
	return function()
		return lazy_load.create_config(name)
	end
end

require("vim.lsp._watchfiles")._watchfunc = function(_, _, _)
	return true
end

require("lazy").setup({
	{ "dstein64/vim-startuptime", lazy = false },
	{ "nvim-lua/plenary.nvim" },

	-- treesitter {{
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
		branch = "main",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
			-- "nvim-treesitter/playground",
			"SmiteshP/nvim-navic",
			"numToStr/Comment.nvim",
		},
		config = load_config("treesitter"),
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		event = on_file_open,
		after = "nvim-treesitter",
		config = load_config("treesitter-context"),
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		event = on_file_open,
		after = "nvim-treesitter",
		requires = "nvim-treesitter/nvim-treesitter",
		config = load_config("treesitter-textobjects"),
	},
	{
		"windwp/nvim-ts-autotag",
		event = on_file_open,
		after = "nvim-treesitter",
	},
	-- }} treesitter
	-- {
	-- 	"nvim-treesitter/playground",
	-- 	event = on_file_open,
	-- },
	-- {
	--     'SmiteshP/nvim-navic',
	-- },

	{ "folke/todo-comments.nvim" },
	{
		"lewis6991/gitsigns.nvim",
		lazy = true,
		cmd = { "Gitsigns" },
		event = on_file_open,
		requires = { "nvim-lua/plenary.nvim" },
		config = load_config("gitsigns"),
	},

	{
		"sindrets/diffview.nvim",
		cmd = {
			"DiffviewOpen",
		},
	},

	-- {
	--     'tpope/vim-surround',
	--     event = on_file_open,
	-- },

	{
		"kylechui/nvim-surround",
		-- version = "*",     -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},

	{
		"L3MON4D3/LuaSnip",
		-- tag = "v2.2.0", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- opts = true,
		event = on_file_open,
		config = load_config("luasnip"),
		build = "make install_jsregexp",
	},
	"rafamadriz/friendly-snippets",

	-- Use dependency and run lua function after load
	-- use {
	--     'SirVer/ultisnips',
	--     opts = true,
	--     setup = require "lazy_load".on_file_open "ultisnips"
	-- };
	--
	-- use {
	--     'honza/vim-snippets',
	--     opts = true,
	--     setup = require "lazy_load".on_file_open "vim-snippets"
	-- };

	-- auto expand
	-- use "cohama/lexima.vim"

	-- auto expand
	-- use {'Raimondi/delimitMate'}

	-- auto expand
	-- use {'rstacruz/vim-closer'}
	-- use {'tpope/vim-endwise', after="vim-closer"}
	{
		"tpope/vim-eunuch",
		cmd = lazy_load.eunuch_cmds,
	},

	{
		"windwp/nvim-autopairs",
		lazy = true,
		event = on_file_open,
		config = function()
			require("nvim-autopairs").setup()
		end,
	},

	-- use { 'neoclide/coc-pairs' }

	-- use {
	--     'tpope/vim-fugitive',
	--     opts = true,
	--     setup = require "lazy_load".on_file_open "vim-fugitive",
	-- }
	{ "tpope/vim-repeat" },

	{
		"numToStr/Comment.nvim",
		after = "nvim-treesitter",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		event = on_file_open,
		config = load_config("comment"),
	},
	--
	-- use {
	--     'preservim/nerdtree',
	--     opts = true,
	--     cmd = {
	--         'NERDTree',
	--     }
	-- }
	--
	-- -- LSP
	-- -- use {'neoclide/coc.nvim', run = {'yarn install --frozen-lockfile'}}

	-- LSP {{
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = load_config("lsp"),
		dependencies = {
			"mrcjkb/rustaceanvim",
			"akinsho/flutter-tools.nvim",
			"ThePrimeagen/refactoring.nvim",
			"j-hui/fidget.nvim",
		},
		event = on_file_open,
		-- config = require "lazy_load".create_config "lsp",
	},

	-- {
	-- 	"felpafel/inlay-hint.nvim",
	-- 	event = "LspAttach",
	-- 	branch = "nightly",
	-- 	opts = {
	-- 		virt_text_pos = "eol",
	-- 	},
	-- 	-- config = function()
	-- 	--     require("lsp-inlayhints").setup()
	-- 	-- end
	-- },

	{
		"j-hui/fidget.nvim",
		lazy = true,
		event = on_file_open,
		branch = "legacy",
		-- opts = true,
		-- after = 'nvim-lspconfig',
		config = function()
			require("fidget").setup({
				window = {
					blend = 0,
				},
			})
		end,
	},

	{
		"aznhe21/actions-preview.nvim",
		lazy = true,
		event = on_file_open,
		after = "nvim-telescope/telescope.nvim",
		config = function()
			require("actions-preview").setup({
				telescope = require("telescope.themes").get_ivy(),

				-- telescope = vim.tbl_extend("force", require("telescope.themes").get_ivy())
			})
			vim.keymap.set({ "v", "n" }, "gf", require("actions-preview").code_actions)
		end,
	},

	{
		"mrcjkb/rustaceanvim",
		lazy = true, -- This plugin is already lazy
	},

	{
		"ThePrimeagen/refactoring.nvim",
		-- opts = true,
		-- after = 'nvim-lspconfig',
		-- dependencies = {
		--     "nvim-lua/plenary.nvim",
		-- }
	},

	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvim-lspconfig",
			"refactoring.nvim",
		},
		lazy = true,
		event = on_file_open,
		-- after = { 'nvim-lspconfig', 'refactoring.nvim' },
		config = load_config("null-ls"),
		-- config = require "lazy_load".create_config "null-ls",
	},

	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
	-- }} LSP

	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		event = on_file_open,
	},

	-- -- completion
	-- -- use { 'ms-jpq/coq_nvim' }
	{
		"hrsh7th/nvim-cmp",
		lazy = true,
		event = { "CmdLineEnter", table.unpack(on_file_open) },
		config = load_config("nvim-cmp"),
		dependencies = {
			-- 'windwp/nvim-autopairs',
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
			"saadparwaiz1/cmp_luasnip",
		},
		-- after = { 'cmp-nvim-lsp', 'cmp-nvim-lsp-signature-help', 'lsp_lines.nvim' }
	},

	-- {
	-- 	"kosayoda/nvim-lightbulb",
	-- 	lazy = true,
	-- 	event = on_file_open,
	-- 	dependencies = {
	-- 		"antoinemadec/FixCursorHold.nvim",
	-- 	},
	-- 	after = "nvim-lspconfig",
	-- 	config = function()
	-- 		require("nvim-lightbulb").setup({
	-- 			autocmd = { enabled = true },
	-- 			ignore = {
	-- 				ft = {
	-- 					"none-ls",
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- },

	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},

	{ "https://github.com/mbbill/undotree" },

	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
		},
		-- opts = true,
		config = load_config("nvim-ufo"),
		lazy = true,
		event = on_file_open,
		-- config = require "lazy_load".create_config "nvim-ufo",
	},
	-- }}Editing

	-- Appereance{{
	{
		"kyazdani42/nvim-web-devicons",
		-- opts = true,
		event = on_file_open,
	},

	{
		"hoob3rt/lualine.nvim",
		lazy = true,
		event = { "VimEnter", "ModeChanged", table.unpack(on_file_open) },
		config = load_config("status"),
		-- config = require "lazy_load".create_config "status"
	},

	{
		"Bekaboo/dropbar.nvim",
		-- optional, but required for fuzzy finder support
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		config = function()
			local dropbar_api = require("dropbar.api")
			vim.keymap.set("n", "<leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
			vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
			vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
		end,
	},

	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				float = {
					transparent = true, -- enable transparent floating windows
					solid = false, -- use solid styling for floating windows, see |winborder|
				},
				auto_integrations = true,
				transparent_background = true,
				integrations = {
					gitsigns = true,
					treesitter = true,
					barbar = true,
					rainbow_delimiters = true,
					treesitter_context = true,
					ufo = true,
					telescope = {
						enabled = true,
					},
				},
			})
			vim.api.nvim_command("colorscheme catppuccin")
		end,
	},

	{
		"romgrk/barbar.nvim",
		dependencies = { "nvim-web-devicons" },
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		-- opts = {},
		config = load_config("barbar"),
		-- opts = true,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		-- opts = true,
		event = on_file_open,
		config = load_config("blankline"),
	},

	{
		"folke/twilight.nvim",
		lazy = true,
		event = on_file_open,
		init = function()
			-- require("twilight").enable();
		end,
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},

	{
		"https://gitlab.com/HiPhish/rainbow-delimiters.nvim.git",
		config = function()
			-- This module contains a number of default definitions
			local rainbow_delimiters = require("rainbow-delimiters")
			vim.g.rainbow_delimiters = {
				strategy = {
					[""] = rainbow_delimiters.strategy["global"],
					commonlisp = rainbow_delimiters.strategy["local"],
				},
				query = {
					[""] = "rainbow-delimiters",
					latex = "rainbow-blocks",
				},
				highlight = {
					"RainbowDelimiterRed",
					"RainbowDelimiterYellow",
					"RainbowDelimiterBlue",
					"RainbowDelimiterOrange",
					"RainbowDelimiterGreen",
					"RainbowDelimiterViolet",
					"RainbowDelimiterCyan",
				},
			}
		end,
		lazy = true,
		event = on_file_open,
	},

	-- }} appereance

	{
		"editorconfig/editorconfig-vim",
		-- opts = true,
		event = on_file_open,
		setup = function()
			require("editorconfig")
		end,
	},

	-- Tooling {{
	{
		"nvim-telescope/telescope.nvim",
		config = load_config("telescope"),
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = { "Telescope" },
	},

	{
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "make",
		after = "telescope.nvim",
	},

	{
		"nvim-pack/nvim-spectre",
		after = "nvim-lua/plenary.nvim",
		config = load_config("spectre"),
	},

	{
		"MagicDuck/grug-far.nvim",
		lazy = true,
		cmd = { "GrugFar", "GrugFarWithin" },
		opts = {
			engine = "ripgrep",
		},
	},

	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {
			keymaps = {
				-- ["-"] = {"actions.open", mode = "n"},
			},
			git = {
				-- Return true to automatically git add/mv/rm files
				add = function(path)
					return false
				end,
				mv = function(src_path, dest_path)
					return true
				end,
				rm = function(path)
					return false
				end,
			},
		},
		init = function()
			vim.keymap.set("n", "<leader>-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
		end,
		-- Optional dependencies
		dependencies = { { "nvim-mini/mini.icons", opts = {} } },
		-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
		-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
		lazy = false,
	},

	{
		"stevearc/overseer.nvim",
		opts = { templates = { "builtin" } },
		tag = "v1.6.0",
		keys = {
			{
				"<leader>rt",
				":OverseerToggle<cr>",
			},
			{
				"<leader>rr",
				":OverseerRun<cr>",
			},
		},
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			delay = 500,
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},

	{
		"https://github.com/folke/snacks.nvim",
		opts = {
			indent = {},
			bigfile = {},
			input = {
				-- position = "right",
			},
			picker = {},
			styles = {
				input = {
					relative = "cursor",
				},
			},
		},
	},

	{ "junegunn/fzf" },

	{
		"junegunn/fzf.vim",
		name = "fzf.vim",
		dependencies = { "junegunn/fzf" },
		-- opts = true,
		cmd = lazy_load.fzf_cmds,
	},

	{
		"stevearc/conform.nvim",
		lazy = true,
		event = on_file_open,
		config = load_config("conform"),
	},

	{
		"folke/persistence.nvim",
		lazy = false,
		config = function()
			require("persistence").setup({})
			vim.api.nvim_create_autocmd({ "User" }, {
				pattern = "PersistenceSavePre",
				callback = function()
					-- saving barbar session
					vim.api.nvim_exec_autocmds("User", { pattern = "SessionSavePre" })
				end,
			})
		end,
		-- add any custom options here
		init = function()
			-- load the session for the current directory
			vim.keymap.set("n", "<leader>qs", function()
				require("persistence").load()
			end)

			-- select a session to load
			vim.keymap.set("n", "<leader>qS", function()
				require("persistence").select()
			end)

			-- load the last session
			vim.keymap.set("n", "<leader>ql", function()
				require("persistence").load({ last = true })
			end)

			-- stop Persistence => session won't be saved on exit
			vim.keymap.set("n", "<leader>qd", function()
				require("persistence").stop()
			end)
		end,
	},

	-- }} Tooling

	{
		"vyfor/cord.nvim",
		build = ":Cord update",
		config = function()
			local blacklist = {
				"/home/uskrai/project/private",
				"/home/uskrai/.local/share/mind.nvim",
			}

			local is_blacklisted = function(opts)
				for _, value in pairs(blacklist) do
					if string.match(opts.workspace_dir, value) then
						return true
					end
				end
			end

			require("cord").setup({
				text = {
					viewing = function(opts)
						return is_blacklisted(opts) and "Viewing a file" or ("Viewing " .. opts.filename)
					end,
					editing = function(opts)
						return is_blacklisted(opts) and "Editing a file" or ("Editing " .. opts.filename)
					end,
					workspace = function(opts)
						if is_blacklisted(opts) then
							return 'Working'
						end

						return "Working on " .. opts.workspace
					end,
				},
			})
		end,
		-- opts = {}
	},

	{
		"tpope/vim-sleuth",
		-- opts = true,
		event = on_file_open,
	},

	-- FOLD
	{
		"kevinhwang91/promise-async",
	},

	-- FOLD
	-- use {
	--     'Konfekt/FastFold',
	--     opts = true,
	--     setup = require "lazy_load".on_file_open "FastFold",
	-- }

	-- Language {{
	-- {
	--     'Iron-E/rust.vim',
	--     ft = 'rust',
	--     branch = "feature/struct-definition-identifiers"
	-- },

	"tyru/open-browser.vim",
	-- "weirongxu/plantuml-previewer.vim",
	"liuchengxu/graphviz.vim",

	{
		"udalov/kotlin-vim",
		ft = "kotlin",
	},
	{
		"RustemB/sixtyfps-vim",
		ft = "sixtyfps",
	},

	{
		"stephpy/vim-php-cs-fixer",
		ft = "php",
	},

	{
		"aklt/plantuml-syntax",
	},

	{
		"lervag/vimtex",
		ft = "tex",
	},
	--
	-- -- use { 'jackguo380/vim-lsp-cxx-highlight' }
	--
	-- use {
	--     'sheerun/vim-polyglot',
	--     opts = true,
	-- }
	"jwalton512/vim-blade",
	-- {
	--     'simrat39/rust-tools.nvim',
	--     dependencies = {
	--         'neovim/nvim-lspconfig',
	--     },
	--     -- ft = 'rust',
	--     -- opts = true,
	--     after = 'nvim-lspconfig',
	--     config = load_config("rust-tools")
	--     -- config = require "lazy_load".create_config "rust-tools"
	-- },

	-- {
	--     'akinsho/flutter-tools.nvim',
	--     dependencies = {
	--         'neovim/nvim-lspconfig',
	--     },
	-- },

	-- }} Language
})
