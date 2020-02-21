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
