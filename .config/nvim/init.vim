set nocompatible
filetype plugin on
filetype plugin indent on
set smartindent
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
"set background=dark


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


" Set indendation for yaml files
" #==================================================================================#
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
" #==================================================================================#


" colorscheme configs
" #==================================================================================#
"colorscheme gruvbox
colorscheme pablo " Has better light/dark colors

" Make background transparent
" Keep this before colorscheme setting
hi Normal     ctermbg=NONE guibg=NONE
hi LineNr     ctermbg=NONE guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE

" Update background based on time of day
" TODO: Look for a better solution
if strftime("%H") < 20
  set background=light
else
  set background=dark
endif
" #==================================================================================#



