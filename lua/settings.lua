-- Configuración básica
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = true
vim.opt.scrolloff = 8

-- Indentación y tabulación
vim.g.editorconfig = true
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
vim.opt.colorcolumn = "156"
vim.opt.showmatch = true
vim.opt.showcmd = true
vim.o.winborder = "rounded"

-- Comportamiento
vim.opt.timeout = true
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.autoread = true
vim.o.mouse = "a"
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = (function()
    if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
        -- Windows: usa %LOCALAPPDATA%\nvim-data\undo
        return vim.fn.stdpath("data") .. "\\undo"
    else
        -- Linux/macOS: usa ~/.local/share/nvim/undodir
        return os.getenv("HOME") .. "/.local/share/nvim/undodir"
    end
end)()
vim.opt.clipboard:append("unnamedplus")
vim.opt.encoding = "UTF-8"

vim.opt.isfname:append("@-@")
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
    pattern = "*",
    desc = "Highlight yanked text",
    callback = function()
        vim.highlight.on_yank({ visual = true, timeout = 200 })
    end,
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "help",
    command = "wincmdL L",
})
vim.api.nvim_create_autocmd("VimResized", {
    command = "wincmd =",
})
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("no_auto_comment", {}),
    callback = function()
        vim.opt.formatoptions:remove({ "c", "r", "o" })
    end,
})
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
    group = vim.api.nvim_create_augroup("active_cursorline", { clear = true }),
    callback = function()
        vim.opt_local.cursorline = true
    end,
})
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
    group = "active_cursorline",
    callback = function()
        vim.opt_local.cursorline = false
    end,
})
vim.api.nvim_create_autocmd("CursorMoved", {
    group = vim.api.nvim_create_augroup("LspReferenceHighlight", { clear = true }),
    desc = "Highlight references under cursor",
    callback = function()
        if vim.fn.mode() ~= "i" then
            local clients = vim.lsp.get_clients({ bufnr = 0 })
            local support_highlight = false
            for _, client in ipairs(clients) do
                if client.server_capabilities.documentHighlightProvider then
                    support_highlight = true
                    break
                end
            end
            if support_highlight then
                vim.lsp.buf.clear_references()
                vim.lsp.buf.document_highlight()
            end
        end
    end,
})
vim.api.nvim_create_autocmd("CursorMovedI", {
    group = "LspReferenceHighlight",
    desc = "Clear reference highlights in insert mode",
    callback = function()
        vim.lsp.buf.clear_references()
    end,
})
