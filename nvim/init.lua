vim.cmd('source ~/.config/nvim/setup.vim')

vim.api.nvim_set_hl(0, "@variable", { fg = "#839496" })
vim.api.nvim_set_hl(0, "@variable.parameter", { italic = false })

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

require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "c", "cpp", "java",
    "python", "rust", "go",
    "html", "css", "lua",
    "javascript", "typescript",
    "markdown", "markdown_inline",
    "toml", "yaml", "tsx" 
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>", 
      node_incremental = "<CR>",  
      node_decremental = "<BS>", 
    },
  },
})

local builtin = require("telescope.builtin")
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

local cmp = require('cmp')
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    {
      name = 'buffer',
      option = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end
      }
    },
    { name = 'path' },
  })
})


