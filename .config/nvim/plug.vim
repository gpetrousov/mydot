" Plugin manager https://github.com/junegunn/vim-plug/wiki/tutorial
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'tpope/vim-sensible' " Commong agreements for vim
Plug 'tpope/vim-commentary' " Comment stuff out. Use gcc to comment/uncomment out a line.
Plug 'airblade/vim-gitgutter' " Shows git diff as you edit
Plug 'mileszs/ack.vim' " Vim plugin for the Perl module / CLI script 'ack'
Plug 'vim-airline/vim-airline' " When the plugin is correctly loaded, Vim will draw a nice statusline at the bottom of each window.
Plug 'hashivim/vim-terraform' " Tab completion and syntax highlight for Terraform
Plug 'RRethy/vim-illuminate' " Underlines word under cursor and all of its occurences
Plug 'lepture/vim-jinja' " Syntax highlight for Jinja templates
Plug 'morhetz/gruvbox' " Theme for vim https://github.com/morhetz/gruvbox
Plug 'joshdick/onedark.vim' " Theme for vim https://github.com/joshdick/onedark.vim'
Plug 'tmux-plugins/vim-tmux' " A tmux.conf multitool https://github.com/tmux-plugins/vim-tmux
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intellisense engine for Vim8 & Neovim, full language server protocol support as VSCode
Plug 'elzr/vim-json' " JSON plugin
Plug 'stephpy/vim-yaml' " YAML color syntax plugin
Plug 'tarekbecker/vim-yaml-formatter' " YAML formatter
Plug 'tpope/vim-surround' " Use cs(t) to change the surrounding elements of a string
Plug 'jiangmiao/auto-pairs' " Insert or delete brackets, parens, quotes in pair.
Plug 'preservim/NERDTree' " Display a file tree
Plug 'kyazdani42/nvim-web-devicons' " Icon pack for NERDTree
Plug 'ryanoasis/vim-devicons' " Icon pack for NERDTree

" syntax support for the file tree
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
