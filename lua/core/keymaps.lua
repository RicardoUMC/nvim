-- Configuración de tecla lider
vim.g.mapleader = " "

-- Mapeos personalizados
vim.api.nvim_set_keymap("i", "jk", "<ESC>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-M-Left>", "<C-w>h", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-M-Down>", "<C-w>j", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-M-Up>", "<C-w>k", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-M-Right>", "<C-w>l", { noremap = true })
vim.api.nvim_set_keymap("n", "<A-a>", "ggVG", { noremap = true })

--vim.api.nvim_set_keymap("n", "<C-b>", ":NERDTreeToggle<CR>", { noremap = true })
