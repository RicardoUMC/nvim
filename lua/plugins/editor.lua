return {
    {
        --"jiangmiao/auto-pairs",
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
            require("nvim-surround").setup({})
        end,
    },
    {
        "chrisgrieser/nvim-spider",
        lazy = true,
        keys = {
            { "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" } },
            { "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" } },
            { "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" } },
            { "E", "<cmd>lua require('spider').motion('ge')<CR>", mode = { "n", "o", "x" } },
        },
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            { "rcarriga/nvim-notify", opts = { render = "compact", background_colour = "#000000" } },
        },
        opts = {
            cmdline = {
                view = "cmdline",
                -- view = "cmdline_popup",
                format = {
                    cmdline = { pattern = "^:", icon = "", lang = "vim" },
                    search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
                    search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
                    filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
                    lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
                    help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
                    input = { view = "cmdline_input", icon = "󰥻 " }, -- Used by input()
                },
                presets = {
                    bottom_search = false,
                    command_palette = true,
                    lsp_doc_border = true,
                },
            },
        },
        config = function(_, opts)
            require("noice").setup(opts)

            vim.api.nvim_create_autocmd("RecordingEnter", {
                callback = function()
                    local reg = vim.fn.reg_recording()
                    require("noice").notify(
                        "Recording macro: @" .. reg,
                        vim.log.levels.INFO,
                        { title = "Macro Recording", timeout = 2000, merge = false }
                    )
                end,
            })

            vim.api.nvim_create_autocmd("RecordingLeave", {
                callback = function()
                    require("noice").notify(
                        "Macro recording stopped",
                        vim.log.levels.INFO,
                        { title = "Macro Recording", timeout = 500, merge = false }
                    )
                end,
            })
        end,
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "helix",
            spec = {
                { "<leader>u", group = "ui" },
                { "<leader>s", group = "search" },
                { "<leader>f", group = "file" },
                { "<leader>b", group = "buffer" },
                { "<leader>g", group = "git" },
                { "<leader>d", group = "debug" },
                { "<leader>h", group = "harpoon" },
                { "<leader>R", group = "rest" },
            },
            delay = function()
                return 0
            end,
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
}
