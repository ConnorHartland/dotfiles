" Use vim-plug as the plugin manager
call plug#begin('~/.config/nvim/plugged')

" Essential plugins
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Language-specific plugins
Plug 'fatih/vim-go'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'elzr/vim-json'
Plug 'stephpy/vim-yaml'

" DevOps-specific plugins
Plug 'hashivim/vim-terraform'
Plug 'pearofducks/ansible-vim'
Plug 'skanehira/vim-docker'
Plug 'andrewstuart/vim-kubernetes'

" Other useful plugins
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'mbbill/undotree'

call plug#end()

" Plugin-specific configurations and mappings
" ...

" Other Neovim configurations and customizations
" ...
