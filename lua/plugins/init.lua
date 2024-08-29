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


local lazy_load = require "lazy_load"

local function on_file_open()
    return {
        "BufRead", "BufWinEnter", "BufNewFile",
    }
end

local function load_config(name)
    return function()
        return lazy_load.create_config(name)
    end
end

require('vim.lsp._watchfiles')._watchfunc = function(_, _, _) return true end

require("lazy").setup({
    { 'nvim-lua/plenary.nvim' },
    {
        'ggandor/leap.nvim',
        opt = true,
        event = on_file_open(),
        config = function()
            require "leap".add_default_mappings()
        end
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        event = on_file_open(),
        cmd = treesitter_cmds,
        dependencies = {
            'JoosepAlviste/nvim-ts-context-commentstring',
            'nvim-treesitter/nvim-treesitter-context',
            'nvim-treesitter/playground',
            'SmiteshP/nvim-navic',
            'numToStr/Comment.nvim',
        },
        config = load_config("treesitter")
    },
    {
        'JoosepAlviste/nvim-ts-context-commentstring',
        after = 'nvim-treesitter',
        setup = function()
            vim.g.skip_ts_context_commentstring_module = true
            require('ts_context_commentstring').setup {
                enable_autocmd = false,
            }
        end
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        after = 'nvim-treesitter',
        config = load_config("treesitter-context")
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
        requires = "nvim-treesitter/nvim-treesitter",
        config = load_config("treesitter-textobjects")
    },
    {
        'windwp/nvim-ts-autotag',
        after = 'nvim-treesitter',
    },
    -- treesitter plugin
    {
        'nvim-treesitter/playground',
    },
    -- {
    --     'SmiteshP/nvim-navic',
    -- },

    {
        'https://gitlab.com/HiPhish/rainbow-delimiters.nvim.git',
        config = function()
            -- This module contains a number of default definitions
            local rainbow_delimiters = require 'rainbow-delimiters'
            vim.g.rainbow_delimiters = {
                strategy = {
                    [''] = rainbow_delimiters.strategy['global'],
                    commonlisp = rainbow_delimiters.strategy['local'],
                },
                query = {
                    [''] = 'rainbow-delimiters',
                    latex = 'rainbow-blocks',
                },
                highlight = {
                    'RainbowDelimiterRed',
                    'RainbowDelimiterYellow',
                    'RainbowDelimiterBlue',
                    'RainbowDelimiterOrange',
                    'RainbowDelimiterGreen',
                    'RainbowDelimiterViolet',
                    'RainbowDelimiterCyan',
                },
            }
        end
        -- event = on_file_open()
    },

    { "folke/todo-comments.nvim" },
    {
        'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = load_config("gitsigns")
    },


    {
        'sindrets/diffview.nvim',
        cmd = {
            'DiffviewOpen'
        }
    },

    -- {
    --     'tpope/vim-surround',
    --     event = on_file_open(),
    -- },

    {
        "kylechui/nvim-surround",
        -- version = "*",     -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },

    {
        "L3MON4D3/LuaSnip",
        -- tag = "v2.2.0", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- opt = true,
        event = on_file_open(),
        config = load_config("luasnip"),
        build = "make install_jsregexp",
    },
    "rafamadriz/friendly-snippets",

    -- Use dependency and run lua function after load
    -- use {
    --     'SirVer/ultisnips',
    --     opt = true,
    --     setup = require "lazy_load".on_file_open "ultisnips"
    -- };
    --
    -- use {
    --     'honza/vim-snippets',
    --     opt = true,
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
        'tpope/vim-eunuch',
        cmd = lazy_load.eunuch_cmds,
    },

    {
        'windwp/nvim-autopairs',
        -- opt = true,
        -- event = on_file_open(),
        config = function()
            require("nvim-autopairs").setup()
        end
    },

    -- use { 'neoclide/coc-pairs' }

    -- use {
    --     'tpope/vim-fugitive',
    --     opt = true,
    --     setup = require "lazy_load".on_file_open "vim-fugitive",
    -- }
    { 'tpope/vim-repeat' },

    -- comment
    -- use {'preservim/nerdcommenter'}
    {
        'numToStr/Comment.nvim',
        after = 'nvim-treesitter',
        dependencies = {
            'JoosepAlviste/nvim-ts-context-commentstring',
        },
        event = on_file_open(),
        config = load_config("comment")
        -- config = require "lazy_load".create_config "comment"
    },
    --
    -- use {
    --     'preservim/nerdtree',
    --     opt = true,
    --     cmd = {
    --         'NERDTree',
    --     }
    -- }
    --
    -- -- LSP
    -- -- use {'neoclide/coc.nvim', run = {'yarn install --frozen-lockfile'}}
    -- {
    --     'neovim/nvim-lspconfig',
    --     config = load_config("lsp"),
    --     dependencies = {
    --         -- 'simrat39/rust-tools.nvim',
    --         -- 'akinsho/flutter-tools.nvim',
    --         "ThePrimeagen/refactoring.nvim",
    --         'j-hui/fidget.nvim',
    --     },
    --     event = on_file_open(),
    --     -- config = require "lazy_load".create_config "lsp",
    -- },

    {
        "felpafel/inlay-hint.nvim",
        opts = {
            virt_text_pos = "eol"
        },
        -- config = function()
        --     require("lsp-inlayhints").setup()
        -- end
    },

    {
        "aznhe21/actions-preview.nvim",
        config = function()
            vim.keymap.set({ "v", "n" }, "gf", require("actions-preview").code_actions)
        end,
    },

    {
        'mrcjkb/rustaceanvim',
        lazy = false, -- This plugin is already lazy
        after = "nvim-lspconfig",
        config = load_config("rust-tools"),
    },
    -- {
    --     'simrat39/rust-tools.nvim',
    --     dependencies = {
    --         'neovim/nvim-lspconfig',
    --     },
    --     -- ft = 'rust',
    --     -- opt = true,
    --     after = 'nvim-lspconfig',
    --     config = load_config("rust-tools")
    --     -- config = require "lazy_load".create_config "rust-tools"
    -- },

    {
        'akinsho/flutter-tools.nvim',
        dependencies = {
            'neovim/nvim-lspconfig',
        },
        after = 'nvim-lspconfig',
        config = load_config("flutter-tools"),
        -- opt = true,
        -- config = require "lazy_load".create_config "flutter-tools"
    },

    {
        'j-hui/fidget.nvim',
        branch = 'legacy',
        -- opt = true,
        -- after = 'nvim-lspconfig',
        config = function()
            require "fidget".setup {
                window = {
                    blend = 0
                }
            }
        end
    },
    {
        "ThePrimeagen/refactoring.nvim",
        -- opt = true,
        -- after = 'nvim-lspconfig',
        -- dependencies = {
        --     "nvim-lua/plenary.nvim",
        -- }
    },
    {
        'nvimtools/none-ls.nvim',
        dependencies = {
            'nvim-lspconfig',
            'refactoring.nvim',
        },
        -- after = { 'nvim-lspconfig', 'refactoring.nvim' },
        config = load_config("null-ls"),
        -- config = require "lazy_load".create_config "null-ls",
    },
    {
        'stevearc/conform.nvim',
        config = load_config("conform"),
    },
    {
        "MagicDuck/grug-far.nvim",
        opt = {
            engine = 'astgrep'
        },
    },

    {
        'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
        event = on_file_open(),
    },

    -- -- completion
    -- -- use { 'ms-jpq/coq_nvim' }
    {
        'hrsh7th/nvim-cmp',
        event = on_file_open(),
        config = load_config("nvim-cmp"),
        dependencies = {
            -- 'windwp/nvim-autopairs',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
            "saadparwaiz1/cmp_luasnip",
            "SergioRibera/cmp-dotenv",
        },
        -- after = { 'cmp-nvim-lsp', 'cmp-nvim-lsp-signature-help', 'lsp_lines.nvim' }
    },
    {
        'kosayoda/nvim-lightbulb',
        dependencies = {
            'antoinemadec/FixCursorHold.nvim',
        },
        after = 'nvim-lspconfig',
        config = function()
            require('nvim-lightbulb').setup({
                autocmd = { enabled = true },
                ignore = {
                    ft = {
                        'none-ls'
                    }
                }
            })
        end
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
    -- }}Editing


    -- Appereance{{
    {
        "hoob3rt/lualine.nvim",
        config = load_config("status")
        -- config = require "lazy_load".create_config "status"
    },
    {
        'stevearc/dressing.nvim',
        -- opt = true,
        event = on_file_open(),
        config = function()
            require('dressing').setup();
        end
    },

    {
        'catppuccin/nvim',
        name = "catppuccin",
        config = function()
            vim.g.catppuccin_flavour = "macchiato"
            require("catppuccin").setup {
                transparent_background = true,
                integrations = {
                    gitsigns = true,
                    treesitter = true,
                    barbar = true,
                    rainbow_delimiters = true,
                }
            }
            vim.api.nvim_command "colorscheme catppuccin"
        end
    },

    -- use {
    --     'arcticicestudio/nord-vim',
    --     branch = "main"
    -- }

    {
        'lukas-reineke/indent-blankline.nvim',
        -- opt = true,
        event = on_file_open(),
        config = load_config("blankline")
    },

    {
        "folke/twilight.nvim",
        init = function()
            -- require("twilight").enable();
        end,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },
    -- }} appereance
    {
        'editorconfig/editorconfig-vim',
        -- opt = true,
        event = on_file_open(),
        setup = function()
            require "editorconfig"
        end
    },
    { 'junegunn/fzf' },
    {
        'junegunn/fzf.vim',
        name = "fzf.vim",
        dependencies = { "junegunn/fzf" },
        -- opt = true,
        cmd = lazy_load.fzf_cmds,
    },
    --
    -- -- use { 'jackguo380/vim-lsp-cxx-highlight' }
    --
    -- use {
    --     'sheerun/vim-polyglot',
    --     opt = true,
    -- }
    'jwalton512/vim-blade',
    --
    -- use {
    --     'derekwyatt/vim-fswitch',
    --     opt = true,
    --     ft = {
    --         'cpp',
    --         'c'
    --     }
    -- }
    --
    -- use { 'farmergreg/vim-lastplace' }

    -- {
    --     'luochen1990/rainbow',
    --     -- opt = true,
    --     event = on_file_open(),
    -- },

    -- use { 'andrejlevkovitch/vim-lua-format' }

    -- use {'raymond-w-ko/vim-lua-indent'}

    {
        'nvim-telescope/telescope.nvim',
        config = load_config("telescope"),
        dependencies = { 'nvim-lua/plenary.nvim' },
        cmd = { "Telescope" },
    },

    {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
        after = 'telescope.nvim',
    },
    -- use {
    --     "nvim-telescope/telescope-frecency.nvim",
    --     requires = { "tami5/sqlite.lua" },
    --     after = 'telescope.nvim',
    -- }

    {
        'nvim-pack/nvim-spectre',
        after = 'nvim-lua/plenary.nvim',
        config = load_config("spectre"),
    },

    -- document reading {{
    {
        'lervag/vimtex',
        ft = 'tex'
    },
    -- }} document reading


    -- {
    --     'rmagatti/auto-session',
    --     lazy = false,
    --     init = function()
    --         vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    --         -- vim.o.sessionoptions = "buffers,curdir,folds,help,options,tabpages"
    --         -- vim.o.sessionoptions = "buffers,curdir,folds,help,options,tabpages,resize,winpos"
    --     end,
    --     opts = {}
    --     -- config = function()
    --     --     require("auto-session").setup {
    --     --
    --     --     }
    --     -- end
    -- },
    -- Lua
    {
        "folke/persistence.nvim",
        lazy = false,
        config = function()
            require("persistence").setup {
            }
            vim.api.nvim_create_autocmd({ "User" }, {
                pattern = "PersistenceSavePre",
                callback = function()
                    vim.api.nvim_exec_autocmds('User', { pattern = 'SessionSavePre' })
                end
            })
        end,
        -- add any custom options here
        init = function()
            -- load the session for the current directory
            vim.keymap.set("n", "<leader>qs", function() require("persistence").load() end)

            -- select a session to load
            vim.keymap.set("n", "<leader>qS", function() require("persistence").select() end)

            -- load the last session
            vim.keymap.set("n", "<leader>ql", function() require("persistence").load({ last = true }) end)

            -- stop Persistence => session won't be saved on exit
            vim.keymap.set("n", "<leader>qd", function() require("persistence").stop() end)
        end
    },

    {
        'kyazdani42/nvim-web-devicons',
        -- opt = true,
        event = on_file_open(),
    },

    {
        'romgrk/barbar.nvim',
        dependencies = { 'nvim-web-devicons' },
        init = function() vim.g.barbar_auto_setup = false end,
        -- opts = {},
        config = load_config("barbar"),
        -- opt = true,
        event = on_file_open(),
    },

    -- use {
    --     'gelguy/wilder.nvim',
    --     setup = require"lazy_load".on_file_open"wilder.nvim",
    -- }

    {
        'andweeb/presence.nvim',
        opt = true,
        event = on_file_open(),
        config = function()
            require("presence").setup({
                blacklist = {
                    "/home/uskrai/project/private",
                    "/home/uskrai/.local/share/mind.nvim",
                    "/home/uskrai/project/go/filemover"
                }
            })
        end
    },

    {
        'tpope/vim-sleuth',
        -- opt = true,
        event = on_file_open(),
    },

    -- FOLD
    {
        'kevinhwang91/promise-async'
    },
    {
        'kevinhwang91/nvim-ufo',
        dependencies = {
            'kevinhwang91/promise-async'
        },
        -- opt = true,
        config = load_config("nvim-ufo"),
        event = on_file_open(),
        -- config = require "lazy_load".create_config "nvim-ufo",
    },


    -- FOLD
    -- use {
    --     'Konfekt/FastFold',
    --     opt = true,
    --     setup = require "lazy_load".on_file_open "FastFold",
    -- }

    {
        'dinhhuy258/vim-local-history',
        -- opt = true,
        event = on_file_open(),
        build = ":UpdateRemotePlugins"
    },

    -- {
    --     'Iron-E/rust.vim',
    --     ft = 'rust',
    --     branch = "feature/struct-definition-identifiers"
    -- },

    {
        "udalov/kotlin-vim",
        ft = 'kotlin',
    },
    {
        'RustemB/sixtyfps-vim',
        ft = 'sixtyfps',
    },

    {
        'stephpy/vim-php-cs-fixer',
        ft = 'php',
    },

    {
        "aklt/plantuml-syntax"
    },

    "tyru/open-browser.vim",
    -- "weirongxu/plantuml-previewer.vim",
    "liuchengxu/graphviz.vim",

    -- -- note taking
    -- {
    --     'phaazon/mind.nvim',
    --     branch = 'v2.2',
    --     dependencies = { 'nvim-lua/plenary.nvim' },
    --     cmd = {
    --         'MindOpenMain',
    --         'MindOpenProject',
    --         'MindOpenSmartProject',
    --         'MindReloadState',
    --         'MindClose'
    --     },
    --     config = function()
    --         require 'mind'.setup()
    --     end
    -- },

    -- use { 'ja-ford/delaytrain.nvim',
    --     config = function()
    --         require('delaytrain').setup {
    --             delay_ms = 1000,
    --         }
    --     end
    -- };
})
