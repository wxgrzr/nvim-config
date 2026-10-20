vim.loader.enable()

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- Order matters: options/keymaps/autocmds first, then plugins. Within plugins,
-- `ui` must precede telescope/neo-tree (it mocks nvim-web-devicons) and `lsp`
-- must precede `debug` (mason is set up there).
require 'wg.options'
require 'wg.keymaps'
require 'wg.autocmds'

for _, module in ipairs {
  'ui',
  'git',
  'telescope',
  'lsp',
  'format',
  'completion',
  'treesitter',
  'lint',
  'neo-tree',
  'toggleterm',
  'claude',
  'autopairs',
  'indent-line',
  -- 'debug', -- disabled; needs `delve` and the Go adapter
} do
  require('wg.plugins.' .. module)
end

-- vim: ts=2 sts=2 sw=2 et
