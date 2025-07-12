-- Configuración básica
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = true
vim.opt.scrolloff = 8

-- Indentación y tabulación
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = false

-- Búsqueda y resaltado
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Visualización y apariencia
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "100"
vim.opt.showmatch = true
vim.opt.showcmd = true

-- Comportamiento
vim.opt.timeout = true
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.autoread = true
vim.o.mouse = "a"
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/undodir"
vim.opt.clipboard:append("unnamedplus")
vim.opt.encoding = "UTF-8"

vim.opt.isfname:append("@-@")
