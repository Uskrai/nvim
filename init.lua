table.unpack = table.unpack or unpack

require("init")

vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.linebreak = true
vim.o.hlsearch = true
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.incsearch = true

vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.tabstop = 2
vim.o.backspace = "indent,eol,start"

vim.o.mouse = "a"
vim.o.clipboard = "unnamedplus"

vim.o.termguicolors = true

vim.g.local_history_new_change_delay = 30
vim.g.local_history_max_changes = 100000
vim.g.local_history_path = vim.fs.joinpath(vim.env.XDG_DATA_HOME, "/local-history")
