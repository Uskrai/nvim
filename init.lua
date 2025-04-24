
table.unpack = table.unpack or unpack

require "init";


vim.keymap.set('n', "<leader>ff", "<cmd>Telescope find_files<cr>")
vim.keymap.set('n', "<leader>fg", "<cmd>Telescope live_grep<cr>")
vim.keymap.set('n', "<leader>fb", "<cmd>Telescope buffers<cr>")
vim.keymap.set('n', "<leader>fh", "<cmd>Telescope help_tags<cr>")
vim.keymap.set('n', "<leader>fp", "<cmd>Telescope frecency<cr>")

vim.cmd([[
set number relativenumber

set signcolumn=yes

set linebreak

set hlsearch
set smartcase
set ignorecase
set incsearch

set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set backspace=indent,eol,start

set mouse=a
set clipboard=unnamedplus
]])
