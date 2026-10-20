vim.pack.add { require('wg.utils').gh 'akinsho/toggleterm.nvim' }

require('toggleterm').setup {
  size = function(term)
    if term.direction == 'horizontal' then
      return 15
    elseif term.direction == 'vertical' then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<c-`>]],
  hide_numbers = true,
  shade_filetypes = {},
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  close_on_exit = true,
  shell = vim.o.shell,
  direction = 'float',
  float_opts = {
    border = 'curved',
    winblend = 0,
  },
}
