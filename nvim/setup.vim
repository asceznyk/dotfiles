set bg=dark
set nocompatible
set number
set relativenumber
set wildmenu
set laststatus=0
set mouse=a
set hlsearch
set notitle
set cursorline

syntax enable


call plug#begin()

Plug 'ervandew/supertab'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-abolish'
Plug 'sheerun/vim-polyglot'
Plug 'chrisbra/Colorizer'
Plug 'KabbAmine/vCoolor.vim'
Plug 'vim-scripts/loremipsum'
Plug 'dkarter/bullets.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'godlygeek/tabular'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'lukas-reineke/virt-column.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

set termguicolors

colorscheme solarized

"hi Normal guibg=NONE ctermbg=NONE


" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)


" HTML, XML, Jinja
autocmd FileType html setlocal shiftwidth=2 tabstop=2 expandtab 
autocmd FileType css setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType xml setlocal shiftwidth=2 tabstop=2 expandtab
autocmd Filetype javascript setlocal shiftwidth=2 tabstop=2 expandtab
autocmd Filetype typescript setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType c setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType h setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType cpp setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType text setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType python setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType rust setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType go setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType htmldjango inoremap {{ {{  }}<left><left><left>
autocmd FileType htmldjango inoremap {% {%  %}<left><left><left>
autocmd FileType htmldjango inoremap {# {#  #}<left><left><left>


" Markdown and Journal
autocmd FileType markdown setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType journal setlocal shiftwidth=2 tabstop=2 expandtab


" Custom Mappings
let mapleader=","
xmap <leader>a gaip*
nmap <leader>a gaip*
nmap <leader>s <C-w>s<C-w>j:terminal<CR>
nmap <leader>vs <C-w>v<C-w>l:terminal<CR>
nmap <leader>j :set filetype=journal<CR>
nmap <silent> <leader><leader> :noh<CR>
nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprevious<CR>
noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-f> :NERDTreeFind<CR>
