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
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-tree/nvim-tree.lua'
Plug 'maxmx03/solarized.nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-abolish'
Plug 'chrisbra/Colorizer'
Plug 'dkarter/bullets.vim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'godlygeek/tabular'
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
Plug 'lukas-reineke/virt-column.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
call plug#end()

if has("termguicolors")
  set termguicolors
endif

colorscheme solarized

hi Normal guibg=#000000
hi LineNr guibg=#000000
hi Visual guibg=#073642 guifg=NONE
hi CursorLine guibg=#000000
hi CursorLineNr guibg=#000000 guifg=#FFFFFF cterm=NONE gui=NONE
hi Pmenu guibg=#000000
hi PmenuSel guibg=#000000
hi NvimTreeNormal guibg=#000000
hi TelescopeNormal guibg=#000000
hi TelescopeBorder guibg=#000000
hi TelescopeSelection guibg=#000000 gui=bold
hi TelescopeSelectionCaret guibg=#000000
hi MatchParen guibg=#b58900 guifg=#000000

highlight! link MsgSeparator Normal

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

autocmd FileType html setlocal shiftwidth=2 tabstop=2 expandtab 
autocmd FileType css setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType xml setlocal shiftwidth=2 tabstop=2 expandtab
autocmd Filetype javascript setlocal shiftwidth=2 tabstop=2 expandtab
autocmd Filetype typescript setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType php setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType c setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType h setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType cpp setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType text setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType python setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType rust setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType go setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType lua setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType markdown setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType journal setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType toml setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType bash setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType htmldjango inoremap {{ {{  }}<left><left><left>
autocmd FileType htmldjango inoremap {% {%  %}<left><left><left>
autocmd FileType htmldjango inoremap {# {#  #}<left><left><left>

let mapleader=","
xmap <leader>a gaip*
nmap <leader>a gaip*
nmap <silent> <leader><leader> :noh<CR>
nmap <Tab> :BufferLineCycleNext<CR>
nmap <S-Tab> :BufferLineCyclePrev<CR>
noremap <Leader>y "+y
noremap <Leader>p "+p
nnoremap <leader>w :NvimTreeToggle<CR>
nnoremap <leader>tf :NvimTreeFindFile<CR>


