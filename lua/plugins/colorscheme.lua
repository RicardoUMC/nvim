vim.opt.termguicolors = true

return {
    {
        "rebelot/kanagawa.nvim",
    },
    {
        "EdenEast/nightfox.nvim",
    },
    {
        "Mofiqul/dracula.nvim",
        config = function()
            require("dracula").setup({ italic_comment = true })
        end,
    },
    -- {
    --     "tinted-theming/tinted-vim",
    -- },
    {
        "scottmckendry/cyberdream.nvim",
        config = function()
            require("cyberdream").setup({ italic_comments = true })
        end,
    },
    {
        "hachy/eva01.vim",
    },
    {
        "xero/evangelion.nvim",
    },
    {
        "Shatur/neovim-ayu",
        lazy = false,
        priority = 1000,
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
        "tiagovla/tokyodark.nvim",
    },
    {
        "navarasu/onedark.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            style = "deep",
        },
    },
    {
        "akinsho/horizon.nvim",
        version = "*",
    },
}
