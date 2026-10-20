local o = vim.o

o.number = true
o.relativenumber = true
o.signcolumn = 'yes:1'
o.cursorline = true
o.scrolloff = 5
o.termguicolors = true
o.showmode = false -- statusline already shows it
o.guicursor = ''
o.lazyredraw = true
o.pumheight = 16
o.display = 'lastline'
o.showmatch = true
o.synmaxcol = 1024
o.fillchars = 'eob: ,fold:┄,foldclose:,foldopen:'

o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

o.mouse = 'nvh' -- everything except insert mode
vim.schedule(function() o.clipboard = 'unnamedplus' end) -- deferred: slows startup otherwise

o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.breakindent = true
o.linebreak = true
o.joinspaces = false

o.ignorecase = true
o.smartcase = true
o.gdefault = true
o.inccommand = 'split'

o.splitright = true
o.splitbelow = true

o.undofile = true
o.backup = false
o.autoread = true
o.hidden = true
o.confirm = true
o.modeline = true

o.updatetime = 250
o.timeoutlen = 300
o.belloff = 'all'

o.foldmethod = 'manual'
o.foldlevelstart = 99

-- Don't continue comments on new lines (re-applied per buffer in autocmds.lua,
-- since ftplugins overwrite it).
o.formatoptions = 'njvql'
