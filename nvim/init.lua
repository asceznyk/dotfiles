vim.cmd('source ~/.config/nvim/setup.vim')

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true
vim.opt.colorcolumn = '80'

vim.api.nvim_set_hl(0, "VertSplit", {
  bold = false,
  italic = false,
})

require("virt-column").setup({
  char = "┊",
})

require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
  actions = {
    change_dir = {
      enable = true,
      global = true,
    },
  },
})

