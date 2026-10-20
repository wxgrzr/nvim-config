vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Focus left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Focus right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Focus lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Focus upper window' })
vim.keymap.set('n', '<C-S-h>', '<C-w>H', { desc = 'Move window left' })
vim.keymap.set('n', '<C-S-l>', '<C-w>L', { desc = 'Move window right' })
vim.keymap.set('n', '<C-S-j>', '<C-w>J', { desc = 'Move window down' })
vim.keymap.set('n', '<C-S-k>', '<C-w>K', { desc = 'Move window up' })

vim.keymap.set({ 'n', 'i', 'v' }, '<D-s>', '<Esc>:w<CR>', { silent = true, desc = 'Save file' })

-- Diagnostics
vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },
  virtual_text = true,
  virtual_lines = false,
  jump = {
    on_jump = function(_, bufnr) vim.diagnostic.open_float { bufnr = bufnr, scope = 'cursor', focus = false } end,
  },
}
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostic [Q]uickfix list' })
