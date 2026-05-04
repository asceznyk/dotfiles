vim.g.mapleader = ","

vim.opt.background = "dark"
vim.opt.compatible = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wildmenu = true
vim.opt.laststatus = 0
vim.opt.mouse = "a"
vim.opt.hlsearch = true
vim.opt.title = false
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.colorcolumn = "80"
vim.opt.clipboard = "unnamedplus"

vim.opt.runtimepath:append("/usr/share/tree-sitter")

vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")

vim.cmd([[
  call plug#begin('~/.local/share/nvim/plugged')
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
]])

vim.cmd("colorscheme solarized")

local set_hl = vim.api.nvim_set_hl

set_hl(0, "Normal", { bg = "#000000" })
set_hl(0, "LineNr", { bg = "#000000" })
set_hl(0, "Visual", { bg = "#073642" })
set_hl(0, "CursorLine", { bg = "#000000" })
set_hl(0, "CursorLineNr", { bg = "#000000", fg = "#FFFFFF", bold = false })
set_hl(0, "Pmenu", { bg = "#000000" })
set_hl(0, "PmenuSel", { bg = "#000000" })
set_hl(0, "NvimTreeNormal", { bg = "#000000" })
set_hl(0, "TelescopeNormal", { bg = "#000000" })
set_hl(0, "TelescopeBorder", { bg = "#000000" })
set_hl(0, "TelescopeSelection", { bg = "#000000", bold = true })
set_hl(0, "TelescopeSelectionCaret", { bg = "#000000" })
set_hl(0, "MatchParen", { bg = "#002b36", bold = true })
set_hl(0, "MsgSeparator", { link = "Normal" })
set_hl(0, "@variable", { fg = "#839496" })
set_hl(0, "@variable.parameter", { italic = false })
set_hl(0, "VertSplit", { bold = false, italic = false })
set_hl(0, "VirtColumn", { fg = "#002b36" })

vim.cmd([[
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
augroup user_config
  autocmd!
  autocmd FileType html,css,xml,javascript,typescript,php,c,h,cpp,text,htmldjango,python,rust,go,lua,markdown,journal,toml,yaml,bash setlocal shiftwidth=2 tabstop=2 expandtab
  autocmd FileType htmldjango inoremap <buffer> {{ {{  }}<left><left><left>
  autocmd FileType htmldjango inoremap <buffer> {% {%  %}<left><left><left>
  autocmd FileType htmldjango inoremap <buffer> {# {#  #}<left><left><left>
augroup END
]])

vim.keymap.set("x", "<leader>a", "gaip*", { remap = true })
vim.keymap.set("n", "<leader>a", "gaip*", { remap = true })
vim.keymap.set("n", "<leader><leader>", ":noh<CR>", { silent = true })
vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>")
vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>")
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>w", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>tf", ":NvimTreeFindFile<CR>")
vim.keymap.set("n", "<leader><Left>", ":BufferLineMovePrev<CR>")
vim.keymap.set("n", "<leader><Right>", ":BufferLineMoveNext<CR>")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("bufferline").setup({
  highlights = {
    buffer_selected = { italic = false },
    diagnostic_selected = { italic = false },
    hint_selected = { italic = false },
    info_selected = { italic = false },
    warning_selected = { italic = false },
    error_selected = { italic = false },
    numbers_selected = { italic = false },
    pick_selected = { italic = false },
  }
})

require("virt-column").setup({
  char = "|",
  highlight = "VirtColumn",
})

require("nvim-tree").setup({
  sort = { sorter = "case_sensitive" },
  view = { width = 30 },
  renderer = { group_empty = true },
  filters = { dotfiles = false },
  actions = {
    change_dir = {
      enable = true,
      global = true,
    },
  },
  sync_root_with_cwd = false,
})

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files)
vim.keymap.set("n", "<leader>fg", builtin.live_grep)
vim.keymap.set("n", "<leader>fb", builtin.buffers)
vim.keymap.set("n", "<leader>fh", builtin.help_tags)

local cmp = require("cmp")

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    {
      name = "buffer",
      option = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end
      }
    },
    { name = "path" },
  })
})

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end
})


