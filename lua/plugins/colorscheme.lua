vim.opt.termguicolors = true
vim.g.tinted_background_transparent = 1

return {
    {
        "rebelot/kanagawa.nvim",
        lazy = true,
        priority = 1000,
    },
    {
        "tinted-theming/tinted-vim",
        lazy = true,
        priority = 1000,
    },
    {
        "scottmckendry/cyberdream.nvim",
        lazy = true,
        priority = 1000,
    },
}
