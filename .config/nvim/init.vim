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


" Plugin manager https://github.com/junegunn/vim-plug/wiki/tutorial
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'tpope/vim-sensible' " Commong agreements for vim
Plug 'airblade/vim-gitgutter' " Shows git diff as you edit
Plug 'mileszs/ack.vim' " Vim plugin for the Perl module / CLI script 'ack'
Plug 'vim-airline/vim-airline' " When the plugin is correctly loaded, Vim will draw a nice statusline at the bottom of each window.
Plug 'hashivim/vim-terraform' " Tab completion and syntax highlight for Terraform
Plug 'RRethy/vim-illuminate' " Underlines word under cursor and all of its occurences
Plug 'lepture/vim-jinja' " Syntax highlight for Jinja templates
Plug 'morhetz/gruvbox' " Theme for vim https://github.com/morhetz/gruvbox
Plug 'mrk21/yaml-vim' " YAML syntax/indent plugin for Vim.

" List ends here. Plugins become visible to Vim after this call.
call plug#end()


" colorscheme configs
" #==================================================================================#

colorscheme gruvbox
" #==================================================================================#

