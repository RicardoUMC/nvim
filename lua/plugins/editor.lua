return {
    {
        --"jiangmiao/auto-pairs",
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            cmdline = {
                view = "cmdline_popup", -- "cmdline" or "cmdline_popup"
                format = {
                    cmdline = { icon = " ", lang = "vim" },
                    search_down = { icon = "🔍 ", lang = "regex" },
                    search_up = { icon = "🔍 ", lang = "regex" },
                    filter = { icon = "!", lang = "bash" },
                },
                presets = {
                    bottom_search = true,
                    command_palette = true,
                    lsp_doc_border = true,
                },
            },
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            {
                "rcarriga/nvim-notify",
                opts = {
                    background_colour = "#000000",
                },
            },
        },
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "modern",
            delay = function()
                return 0
            end,
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
    {
        "chrisgrieser/nvim-spider",
        lazy = true,
        keys = {
            { "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" } },
            { "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" } },
            { "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" } },
            { "W", "<cmd>lua require('spider').motion('W')<CR>", mode = { "n", "o", "x" } },
            { "e", "<cmd>lua require('spider').motion('E')<CR>", mode = { "n", "o", "x" } },
            { "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" } },
        },
    },
    {
        "numToStr/Comment.nvim",
        opts = {
            padding = true,
        },
    },
    {
        "kylechui/nvim-surround",
        version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end,
    },
}
