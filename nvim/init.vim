" line number
set number
set relativenumber

" tab
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

" history
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

set guicursor=
set nohlsearch
set hidden
set noerrorbells
set nowrap 
set incsearch
set scrolloff=8
set colorcolumn=80
set signcolumn=yes

call plug#begin()

Plug 'neovim/nvim-lspconfig'

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'projekt0n/github-nvim-theme'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'mbbill/undotree'
Plug 'tpope/vim-surround'
Plug 'lewis6991/gitsigns.nvim'

" telescopte requirements...
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

call plug#end()

" lua plugin config
lua require('plugin.nvim-lspconfig')
lua require('plugin.lualine')
lua require('plugin.gitsigns')

syntax enable
colorscheme dracula

let mapleader = " "

nnoremap <leader>u :UndotreeToggle<CR>
nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <leader>+ :vertical resize +5<CR>
nnoremap <leader>- :vertical resize -5<CR>

" Shortcut for escape
imap jj <Esc>
imap jk <Esc>

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

nnoremap <leader>x :silent !chmod +x %<CR>

" greatest remap ever
" Let me explain, this remap while in visiual mode
" will delete what is currently highlighted and replace it 
" with what is in the register BUT it will YANK (delete) it 
" to a VOID register. Meaning I still have what I originally had
" when I pasted. I don't loose the previous thing I YANKED!
xnoremap <leader>rp "_dP

nnoremap <leader>p "+p
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nmap <leader>Y "+Y

nnoremap <leader>d "_d
vnoremap <leader>d "_d

