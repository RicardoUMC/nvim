return {
    -- {
    --     "MeanderingProgrammer/render-markdown.nvim",
    --     dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    --     ---@module 'render-markdown'
    --     ---@type render.md.UserConfig
    --     opts = {
    --         heading = {
    --             enabled = true,
    --             sign = true,
    --             style = "full",
    --             icons = { "① ", "② ", "③ ", "④ ", "⑤ ", "⑥ " },
    --             left_pad = 1,
    --         },
    --         bullet = {
    --             enabled = true,
    --             icons = { "●", "○", "◆", "◇" },
    --             right_pad = 1,
    --             highlight = "render-markdownBullet",
    --         },
    --     },
    -- },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && npm install && git restore .",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },
    -- {
    --     "OXY2DEV/markview.nvim",
    --     priority = 49,
    --     branch = "main",
    --     lazy = false,
    --     ft = { "markdown", "norg", "rmd", "org", "vimwiki", "Avante" },
    --     init = function()
    --         local filetypes = { "markdown", "norg", "rmd", "org", "vimwiki", "Avante" }
    --
    --         vim.api.nvim_create_autocmd("FileType", {
    --             pattern = filetypes,
    --             callback = function()
    --                 local custom = require("markview.spec").default
    --
    --                 custom.preview.filetypes = filetypes
    --                 custom.preview.ignore_buftypes = {}
    --
    --                 require("markview").setup(custom)
    --             end,
    --         })
    --     end,
    -- },
}
