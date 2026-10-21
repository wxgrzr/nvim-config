vim.pack.add { { src = require('utils').gh 'nvim-treesitter/nvim-treesitter', version = 'main' } }

require('nvim-treesitter').install { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }

---@param buf integer
---@param language string
local function attach(buf, language)
  if not vim.treesitter.language.add(language) then return end
  vim.treesitter.start(buf, language)

  -- Use treesitter indentation only where an indent query exists.
  if vim.treesitter.query.get(language, 'indents') ~= nil then vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
end

local available = require('nvim-treesitter').get_available()

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('wg-treesitter', { clear = true }),
  callback = function(args)
    local buf = args.buf
    local language = vim.treesitter.language.get_lang(args.match)
    if not language then return end

    if vim.tbl_contains(require('nvim-treesitter').get_installed 'parsers', language) then
      attach(buf, language)
    elseif vim.tbl_contains(available, language) then
      -- Auto-install missing parsers, then attach.
      require('nvim-treesitter').install(language):await(function() attach(buf, language) end)
    else
      attach(buf, language)
    end
  end,
})
