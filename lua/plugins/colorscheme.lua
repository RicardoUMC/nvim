vim.opt.termguicolors = true

return {
    { "RicardoUMC/tokyocity.nvim", dev = true, lazy = false, priority = 1000 },
    {
        "vague-theme/vague.nvim",
        config = function()
            require("vague").setup({
                transparent = false,
                bold = true,
                italic = true,
            })
        end,
    },
    {
        "rebelot/kanagawa.nvim",
        config = function()
            require("kanagawa").setup({
                commentStyle = { italic = true },
                functionStyle = { bold = true },
                keywordStyle = { bold = true },
                statementStyle = { bold = true },
                typeStyle = { italic = true, bold = true },
                transparent = true,
            })
        end,
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
        opts = {
            transparent = false,
            styles = {
                comments = { italic = true },
                keywords = { italic = true },
                functions = { italic = true },
                variables = { italic = true },
            },
        },
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
