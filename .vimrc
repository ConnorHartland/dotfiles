" Use Vim settings, rather than Vi settings
set nocompatible

" Enable syntax highlighting
syntax on

" Enable line numbers
set number

" Enable auto indent
set autoindent

" Use spaces instead of tabs
set expandtab
set tabstop=2
set shiftwidth=2

" Enable mouse support
set mouse=a

" Install Plugin
call plug#begin('~/.config/nvim/plugged')
Plug 'hashvim/vim-terraform'
Plug 'ansible/ansible-vim'
Plug 'stephpy/vim-yaml'
call plug#end()
