set nocompatible
filetype plugin on
filetype plugin indent on
set smartindent
set number
set incsearch
set ruler
set tabstop=4
syntax on
set ignorecase
set smartcase
set scrolloff=4 " Keep 4 lines below and above the cursor
set updatetime=300
"set background=dark
set showcmd
set wildmenu


" netrw configs
" #==================================================================================#
" How the navtree is displayed
let g:netrw_liststyle = 3

" Defines the default proportion of the new window relative to the current window
let g:netrw_winsize = 75

" Use `rm -r` instead of rmdir
let g:netrw_localrmdir='rm -r'

" vsplit netrw to the right window
let g:netrw_altv = 1
" #==================================================================================#

" vim-terraform configuration
" #==================================================================================#
" Allow vim-terraform to align settings automatically with Tabularize.
let g:terraform_align=1

" Allow vim-terraform to automatically format *.tf and *.tfvars files with terraform fmt
let g:terraform_fmt_on_save=1
" #==================================================================================#

" Include plug package manager
" #==================================================================================#
runtime plug.vim
" #==================================================================================#

" Set config for YAML files
" #==================================================================================#
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
let g:yaml_formatter_indent_collection=1
" #==================================================================================#

" Set config for JSON files
" #==================================================================================#
let g:vim_json_syntax_conceal = 0 " Prevent consealing quotes in JSON files
" #==================================================================================#

" Set indendation for SHELL files
" #==================================================================================#
autocmd FileType sh setlocal ts=2 sts=2 sw=2 expandtab
" #==================================================================================#


" color(scheme) configs
" #==================================================================================#
colorscheme onedark

" Setting (cterm|gui)bg to NONE makes background transparent
hi Normal     ctermbg=NONE guibg=NONE
hi LineNr     ctermbg=NONE ctermfg=LightBlue guibg=NONE " Line number color settings
hi SignColumn ctermbg=NONE guibg=NONE
hi Comment ctermfg=Green " Comment color settings
" #==================================================================================#

" Cursor settings
" #==================================================================================#
" Cursor blinking
set guicursor+=n-v-c:blinkon1
set guicursor+=n-v-c:blinkoff1
set guicursor+=i:blinkwait1
" #==================================================================================#

" highlight search settings
" #==================================================================================#
set hlsearch
highlight Search  ctermfg=LightGreen
highlight Search  ctermbg=Darkblue
" #==================================================================================#

" syntax highlight for Groovy/Jenkinsfiles
" #==================================================================================#
au BufNewFile,BufRead Jenkinsfile setf groovy
" #==================================================================================#

" Automatic line wrapping without breaks - https://vim.fandom.com/wiki/Word_wrap_without_line_breaks
" #==================================================================================#
set wrap
set linebreak
set textwidth=0
set wrapmargin=0
" Move through wrapped lines - https://vim.fandom.com/wiki/Move_cursor_by_display_lines_when_wrapping#:~:text=The%20command%20%3Aset%20wrap%20lbr,following%20in%20your%20vimrc%20file.
imap <silent> <Down> <C-o>gj
imap <silent> <Up> <C-o>gk
nmap <silent> <Down> gj
nmap <silent> <Up> gk
noremap <silent> k gk
noremap <silent> j gj
noremap <silent> 0 g0
noremap <silent> $ g$
" #==================================================================================#
