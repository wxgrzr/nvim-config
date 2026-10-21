local gh = require('utils').gh

-- Registered before `colorscheme` so it applies on this load and on any later switch.
vim.api.nvim_create_autocmd('ColorScheme', {
  desc = "Strip background colors so the terminal's own background shows through",
  callback = function()
    local groups = {
      'Normal',
      'NormalNC',
      'NormalFloat',
      'FloatBorder',
      'SignColumn',
      'EndOfBuffer',
      'LineNr',
      'CursorLineNr',
      'StatusLine',
      'StatusLineNC',
      'TabLine',
      'TabLineFill',
      'WinSeparator',
      'Pmenu',
    }
    for _, group in ipairs(groups) do
      local hl = vim.api.nvim_get_hl(0, { name = group })
      hl.bg = nil
      hl.ctermbg = nil
      vim.api.nvim_set_hl(0, group, hl) ---@diagnostic disable-line
    end
  end,
})
vim.cmd.colorscheme 'habamax'

vim.pack.add {
  gh 'NMAC427/guess-indent.nvim',
  gh 'folke/which-key.nvim',
  gh 'folke/todo-comments.nvim',
  gh 'nvim-mini/mini.nvim',
}

require('guess-indent').setup {}
require('todo-comments').setup { signs = false }

require('which-key').setup {
  delay = 0,
  icons = { mappings = vim.g.have_nerd_font },
  spec = {
    { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
    { '<leader>t', group = '[T]oggle' },
    { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
    { 'gr', group = 'LSP Actions', mode = { 'n' } },
  },
}

-- Must run before telescope/neo-tree, which look for nvim-web-devicons.
require('mini.icons').setup()
MiniIcons.mock_nvim_web_devicons()

-- `aa`/`ii` instead of `an`/`in` to avoid clashing with built-in incremental selection (nvim 0.12+).
require('mini.ai').setup {
  mappings = { around_next = 'aa', inside_next = 'ii' },
  n_lines = 500,
}

local statusline = require 'mini.statusline'
statusline.setup { use_icons = vim.g.have_nerd_font }
---@diagnostic disable-next-line: duplicate-set-field
statusline.section_location = function() return '%2l:%-2v' end
