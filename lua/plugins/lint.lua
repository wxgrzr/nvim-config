local gh = require('utils').gh

vim.pack.add { gh 'mfussenegger/nvim-lint', gh 'soulsam480/nvim-oxlint' }

local js_filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' }

local lint = require 'lint'
lint.linters_by_ft = { markdown = { 'markdownlint' } } -- install markdownlint via mason / npm
for _, ft in ipairs(js_filetypes) do
  lint.linters_by_ft[ft] = { 'oxlint' }
end

require('nvim-oxlint').setup {
  opts = {
    run = 'onSave',
    config_path = '.oxlintrc.json',
    enable = true,
    type_aware = true,
    filetypes = js_filetypes,
  },
}

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = vim.api.nvim_create_augroup('wg-lint', { clear = true }),
  callback = function()
    if vim.bo.modifiable then lint.try_lint() end
  end,
})
