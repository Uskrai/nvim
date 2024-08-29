
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

" set foldmethod=syntax
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()

let g:rust_recommended_style = 0

set autoindent
set smartindent

let g:polyglot_disabled = [
      \ 'rust',
  \ ]

set termguicolors

lua require("init")

let g:rust_fold = 1

" colorscheme github_dark

" colorscheme github_*
"au ColorScheme * hi Normal ctermbg=none guibg=none
" nnoremap <expr> <C-p> (len(system('git rev-parse')) ? ':Files' : ':GFiles --exclude-standard --others --cached')."\<cr>"
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fp <cmd>Telescope frecency<cr>


"vim-fswitch
autocmd BufEnter *fmr/src/*.cpp let b:fswitchdst = 'h,hpp' | let b:fswitchlocs = 'reg:|src|include/fmr|'
autocmd BufEnter *fmr/include/fmr/*.h let b:fswitchdst = 'cpp,c' | let b:fswitchlocs = 'reg:|include/fmr|src|'

noremap <Leader>dvo :DiffviewOpen<cr>
noremap <leader>dvc :DiffviewClose<cr>
noremap <leader>dvfh :DiffviewFileHistory<cr>

let g:UltiSnipsExpandTrigger = "<NUL>"

let g:lastplace_ignore = "gitcommit,gitrebase,svn,hgcommit"

let g:rainbow_active = 1

let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1
let g:delimitMate_balance_matchpair = 1

augroup autoformat_settings
  " autocmd FileType bzl AutoFormatBuffer buildifier
  " autocmd FileType c,cpp,proto,arduino AutoFormatBuffer clang-format
  " autocmd FileType c,cpp,proto,arduino Glaive codefmt clang_format_executable='clang-format-14'
  " autocmd FileType dart AutoFormatBuffer dartfmt
  " autocmd FileType go AutoFormatBuffer gofmt
  " autocmd FileType gn AutoFormatBuffer gn
  " autocmd FileType javascript eslint
  " autocmd FileType html,css,sass,scss,less,json,javascript AutoFormatBuffer prettier
  "" autocmd FileType java AutoFormatBuffer google-java-format
  "" autocmd FileType java autocmd BufLeave * :FormatCode

  " autocmd FileType python AutoFormatBuffer yapf
  "" Alternative: autocmd FileType python AutoFormatBuffer autopep8
  " autocmd FileType rust AutoFormatBuffer rustfmt
  " autocmd FileType vue AutoFormatBuffer prettier
augroup END

" autocmd BufWrite *.lua call LuaFormat() 

autocmd filetype blade
  \ autocmd BufRead,BufEnter * set nowrap

let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \   '--shell-escape',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}

" Key bindings can be changed, see below
" call wilder#setup({'modes': [':', '/', '?']})
" call wilder#set_option('renderer', wilder#popupmenu_renderer({
"       \ 'highlighter': wilder#basic_highlighter(),
"       \ 'left': [
"       \   ' ', wilder#popupmenu_devicons(),
"       \ ],
"       \ 'right': [
"       \   ' ', wilder#popupmenu_scrollbar()
"       \ ],
"       \ }))

autocmd BufNewFile,BufRead *.rn 
  \ :set filetype=rune  |
  \ :set syntax=rust |
  \ :set commentstring=//%s |
  \ :set formatoptions=croqnlj |
  \ :set comments="s0:/*!,m: ,ex:*/,s1:/*,mb:*,ex:*/,:///,://!,://"


autocmd FileType rune
  \ let b:closer = 1 |
  \ let b:closer_flags = '([{' 

autocmd BufEnter *.slint :setlocal filetype=slint

autocmd FileType slint
  \ let b:closer = 1 |
  \ let b:closer_flags = '([{' 

" augroup coc
"   inoremap <silent><expr> <C-space> coc#refresh()
"   
" " GoTo code navigation.
"   nmap <silent> gd <Plug>(coc-definition)
"   nmap <silent> gy <Plug>(coc-type-definition)
"   nmap <silent> gi <Plug>(coc-implementation)
"   nmap <silent> gr <Plug>(coc-references)
"   nmap <leader>rn <Plug>(coc-rename)
"
"   xmap <leader>A <Plug>(coc-codeaction-selected)
"   nmap <leader>A <Plug>(coc-codeaction-selected)
"
"   nmap <leader>a <Plug>(coc-codeaction-cursor)
" augroup END


let g:lexima_enable_basic_rules = 0
let g:lexima_enable_newline_rules = 1

function MakeTransparent()
  highlight clear CursorLine
  highlight clear EndOfBuffer
  highlight Normal ctermbg=none
  highlight LineNr ctermbg=none
  highlight Folded ctermbg=none
  highlight NonText ctermbg=none
  highlight SpecialKey ctermbg=none
  highlight VertSplit ctermbg=none
  highlight SignColumn ctermbg=none
  hi Normal guibg=NONE ctermbg=NONE
  " hi BufferCurrent guifg=#FFFF00
  " hi BufferInactive guifg=#888888 guibg=#000000
  " hi BufferInactiveTarget guibg=#000000
  " hi BufferInactiveIndex guibg=#000000
  " hi BufferInactiveSign guibg=#000000
endfunction

" transparent bg
autocmd vimenter * call MakeTransparent()
autocmd ColorScheme * call MakeTransparent()

" autocmd VimEnter * highlight OverLength ctermbg=red ctermfg=white guibg=#592929
" autocmd VimEnter * match OverLength /\%81v.\+/
" autocmd BufNewFile,BufRead * match OverLength /\%81v.\+/
" autocmd BufNewFile,BufRead *.rs match OverLength /\%101v.\+/

" colorscheme material

function SetupRust()
  set tabstop=4
  set shiftwidth=4
  set softtabstop=4
endfunction

autocmd BufNewFile,BufRead *.rs,*.rn,*.xml call SetupRust()

function SetupLatex()
  set tw=80
endfunction

let loaded_netrwPlugin = 1
let g:vimtex_quickfix_open_on_warning = 0

autocmd BufNewFile,BufRead *.tex call SetupLatex()
autocmd BufNewFile,BufRead .envrc setfiletype bash
autocmd BufNewFile,BufRead direnvrc setfiletype bash

" :profile start vim.log
" :profile file *
" :profile func *

let g:local_history_new_change_delay = 30
let g:local_history_max_changes = 100000
let g:local_history_path = $HOME . '/.local-history'
