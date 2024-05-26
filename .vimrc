set number
set relativenumber
set wildmenu
set laststatus=0
set mouse=a

syntax on


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
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'godlygeek/tabular'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()


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
nmap \ <leader>q
nmap <leader>q :NERDTreeToggle<CR>
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


set termguicolors


" Solarized color palette
let s:base03  = '#002B36'
let s:base02  = '#073642'
let s:base01  = '#586E75'
let s:base00  = '#657B83'
let s:base0   = '#839496'
let s:base1   = '#93A1A1'
let s:base2   = '#EEE8D5'
let s:base3   = '#FDF6E3'
let s:yellow  = '#B58900'
let s:orange  = '#CB4B16'
let s:red     = '#DC322F'
let s:magenta = '#D33682'
let s:violet  = '#6C71C4'
let s:blue    = '#268BD2'
let s:cyan    = '#2AA198'
let s:green   = '#859900'


"Syntax Highlighting
execute 'hi Statement guifg=' . s:yellow
execute 'hi Operator guifg=' . s:cyan
execute 'hi Number guifg=' . s:blue
execute 'hi String guifg=' . s:base3
execute 'hi Identifier guifg=' . s:green
execute 'hi Type guifg=' . s:red
execute 'hi Comment guifg=' . s:base02
execute 'hi Todo guibg=' . s:red . ' guifg=#000000'
execute 'hi LineNr guifg='. s:magenta


" set pmenu
hi Pmenu guibg=#000000
hi PmenuSel guibg=#DC322F guifg=#000000

hi Search guibg=#DC322F guifg=#000000

hi Visual guibg=#002B36


