set nocompatible
filetype plugin on
filetype plugin indent on
set number
set hlsearch
set incsearch
set ruler
set tabstop=4
syntax on
set ignorecase
set smartcase
set scrolloff=4 " Keep 4 lines below and above the cursor
set updatetime=300
set background=dark


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
"
" Allow vim-terraform to align settings automatically with Tabularize.
let g:terraform_align=1

" Allow vim-terraform to automatically format *.tf and *.tfvars files with terraform fmt
let g:terraform_fmt_on_save=1
" #==================================================================================#


" Include plug package manager
" #==================================================================================#
runtime plug.vim
" #==================================================================================#


" colorscheme configs
" #==================================================================================#
colorscheme gruvbox

" Make background transparent
" Keep this before colorscheme setting
hi Normal     ctermbg=NONE guibg=NONE
hi LineNr     ctermbg=NONE guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE
" #==================================================================================#
