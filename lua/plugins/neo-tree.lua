local gh = require('utils').gh

vim.pack.add {
  { src = gh 'nvim-neo-tree/neo-tree.nvim', version = vim.version.range '*' },
  gh 'nvim-lua/plenary.nvim',
  gh 'MunifTanjim/nui.nvim',
  gh 'saifulapm/neotree-file-nesting-config',
  gh 'nvim-tree/nvim-web-devicons',
}

vim.keymap.set('n', '<C-n>', '<Cmd>Neotree reveal<CR>', { desc = 'NeoTree reveal', silent = true })

require('neo-tree').setup {
  hide_root_node = true,
  retain_hidden_root_indent = true,
  nesting_rules = require('neotree-file-nesting-config').nesting_rules,
  filesystem = {
    filtered_items = {
      show_hidden_count = false,
      never_show = { '.DS_Store' },
    },
    window = {
      mappings = {
        ['<C-n>'] = 'close_window',
        ['h'] = 'close_node',
        ['<space>'] = 'none',
        ['P'] = { 'toggle_preview', config = { use_float = true } },
      },
    },
  },
  default_component_configs = {
    indent = {
      with_expanders = true,
      expander_collapsed = '',
      expander_expanded = '',
      expander_highlight = 'NeoTreeExpander',
    },
    git_status = {
      symbols = { unstaged = 'x', staged = 's' },
    },
  },
}
