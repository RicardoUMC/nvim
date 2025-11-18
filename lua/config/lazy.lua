local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Fix copy and paste in WSL (Windows Subsystem for Linux)
-- if vim.fn.has("wsl") == 1 then
--     vim.g.clipboard = {
--         name = "win32yank",
--         copy = {
--             ["+"] = "win32yank.exe -i --crlf",
--             ["*"] = "win32yank.exe -i --crlf",
--         },
--         paste = {
--             ["+"] = "win32yank.exe -o --lf",
--             ["*"] = "win32yank.exe -o --lf",
--         },
--         cache_enabled = false,
--     }
-- end

require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "habamax" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})
