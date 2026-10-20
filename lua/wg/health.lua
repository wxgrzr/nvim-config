-- `:checkhealth wg`
return {
  check = function()
    vim.health.start 'wg'

    if vim.version.ge(vim.version(), '0.12') then
      vim.health.ok(("Neovim version is: '%s'"):format(tostring(vim.version())))
    else
      vim.health.error(("Neovim out of date: '%s'. This config needs 0.12+ (vim.pack)"):format(tostring(vim.version())))
    end

    for _, exe in ipairs { 'git', 'make', 'unzip', 'rg' } do
      if vim.fn.executable(exe) == 1 then
        vim.health.ok(("Found executable: '%s'"):format(exe))
      else
        vim.health.warn(("Could not find executable: '%s'"):format(exe))
      end
    end
  end,
}
