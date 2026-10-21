local augroup = vim.api.nvim_create_augroup('wg', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup,
  desc = 'Highlight yanked text',
  callback = function() vim.hl.on_yank() end,
})

vim.api.nvim_create_autocmd('BufEnter', {
  group = augroup,
  desc = "Don't continue comments on new lines (ftplugins re-add these flags)",
  callback = function() vim.opt.formatoptions:remove { 'c', 'r', 'o' } end,
})

-- Runs build steps for plugins after install/update. See `:help vim.pack-events`.
local function run_build(name, cmd, cwd)
  local result = vim.system(cmd, { cwd = cwd }):wait()
  if result.code ~= 0 then
    local output = (result.stderr ~= '' and result.stderr) or result.stdout or ''
    if output == '' then output = 'No output from build command.' end
    vim.notify(('Build failed for %s:\n%s'):format(name, output), vim.log.levels.ERROR)
  end
end

vim.api.nvim_create_autocmd('PackChanged', {
  group = augroup,
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if kind ~= 'install' and kind ~= 'update' then return end

    if name == 'telescope-fzf-native.nvim' and vim.fn.executable 'make' == 1 then
      run_build(name, { 'make' }, ev.data.path)
    elseif name == 'LuaSnip' and vim.fn.executable 'make' == 1 then
      run_build(name, { 'make', 'install_jsregexp' }, ev.data.path)
    elseif name == 'nvim-treesitter' then
      if not ev.data.active then vim.cmd.packadd 'nvim-treesitter' end
      vim.cmd 'TSUpdate'
    end
  end,
})
