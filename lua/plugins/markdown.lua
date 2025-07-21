return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {
            heading = {
                enabled = true,
                sign = true,
                style = "full",
                icons = { "① ", "② ", "③ ", "④ ", "⑤ ", "⑥ " },
                left_pad = 1,
            },
            bullet = {
                enabled = true,
                icons = { "●", "○", "◆", "◇" },
                right_pad = 1,
                highlight = "render-markdownBullet",
            },
        },
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && npm install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },
}
