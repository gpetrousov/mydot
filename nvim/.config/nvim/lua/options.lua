--[[ Migration commands from vimscript ]]

vim.cmd("set nocompatible")
--vim.cmd("filetype plugin on")
--vim.cmd("filetype plugin indent on")
vim.cmd("set smartindent")
vim.cmd('set relativenumber')
vim.cmd('set number')
vim.cmd("set incsearch")
vim.cmd("set ruler")
vim.cmd("syntax on")
vim.cmd("set ignorecase")
vim.cmd("set smartcase")
vim.cmd("set scrolloff=4") -- Keep 4 lines below and above the cursor
vim.cmd("set updatetime=300")
vim.cmd("set background=dark")
vim.cmd("set showcmd")
vim.cmd("set wildmenu")
vim.cmd("set iskeyword+=-") -- treat dash separated words as a word text object

-- Enable 24bit colors
vim.cmd("set termguicolors")


--[[ My tab spacing options ]]
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
