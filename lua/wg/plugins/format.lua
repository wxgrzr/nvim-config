vim.pack.add { require('wg.utils').gh 'stevearc/conform.nvim' }

-- Allowlist of filetypes formatted on save: every filetype with an explicit
-- formatter below. Anything else only formats via <leader>f.
local format_on_save = {
  lua = true,
  python = true,
  rust = true,
  javascript = true,
  javascriptreact = true,
  typescript = true,
  typescriptreact = true,
}

require('conform').setup {
  notify_no_formatters = true,
  notify_on_error = true,
  format_on_save = function(bufnr)
    if format_on_save[vim.bo[bufnr].filetype] then return { timeout_ms = 500 } end
  end,
  default_format_opts = {
    lsp_format = 'fallback', -- use LSP formatting when no external formatter is configured
  },
  formatters_by_ft = {
    rust = { 'rustfmt' },
    python = { 'isort', 'black' }, -- run sequentially
    javascript = { 'prettierd', 'prettier', stop_after_first = true },
    javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
    typescript = { 'prettierd', 'prettier', stop_after_first = true },
    typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
  },
}

vim.keymap.set({ 'n', 'v' }, '<leader>f', function() require('conform').format { async = true } end, { desc = '[F]ormat buffer' })
