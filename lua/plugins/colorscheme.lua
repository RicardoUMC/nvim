vim.opt.termguicolors = true

return {
    {
        "rebelot/kanagawa.nvim",
    },
    -- {
    --     "tinted-theming/tinted-vim",
    -- },
    {
        "scottmckendry/cyberdream.nvim",
    },
    {
        "hachy/eva01.vim",
    },
    {
        "xero/evangelion.nvim",
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({ flavour = "mocha" })
        end,
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    {
        "navarasu/onedark.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            style = "darker",
            transparent = true,
            term_colors = true,
        },
    },
    {
        "akinsho/horizon.nvim",
        version = "*",
    },
}
