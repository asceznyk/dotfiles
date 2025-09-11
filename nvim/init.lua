vim.cmd('source ~/.config/nvim/setup.vim')

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true
vim.opt.colorcolumn = '80'

require("virt-column").setup({
  char = "┊",
})

require("nvim-tree").setup()

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
    dotfiles = true,
  },
})

vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle File Explorer' })
vim.keymap.set('n', '<leader>ff', ':NvimTreeFindFile<CR>', { desc = 'Find current file in NvimTree'})


