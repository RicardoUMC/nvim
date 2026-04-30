return {
    {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" },
        ft = { "markdown", "Avante", "copilot-chat", "opencode_output" },
        opts = {
            anti_conceal = { enabled = false },
            render_modes = { "n", "c", "t" },
            file_types = { "markdown", "Avante", "opencode_output" },
            heading = {
                enabled = true,
                sign = false,
                -- Nerd Font header icon options:
                -- icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
                -- icons = { "󰉫 ", "󰉬 ", "󰉭 ", "󰉮 ", "󰉯 ", "󰉰 " },
                -- icons = { "󰎦 ", "󰎩 ", "󰎬 ", "󰎮 ", "󰎱 ", "󰎳 " },
                icons = { "󰼏 ", "󰼐 ", "󰼑 ", "󰼒 ", "󰼓 ", "󰼔 " },
            },
            bullet = {
                enabled = true,
                -- icons = { "󰧞", "󰄱", "󰝦", "󰐾" },
                highlight = "RenderMarkdownBullet",
            },
        },
    },
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
