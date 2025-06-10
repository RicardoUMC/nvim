vim.o.mouse = "a"

-- Configuración básica
vim.opt.isfname:append("@-@")
vim.opt.signcolumn = "yes"

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.autoindent = true
vim.opt.smartindent = false -- Revisar negativo con treesitter
vim.opt.wrap = true

vim.opt.scrolloff = 8
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showcmd = true
vim.opt.showmatch = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.updatetime = 50
vim.o.timeout = true
vim.o.timeoutlen = 250
