return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
        local custom_onedark = require("lualine.themes.onedark")
        custom_onedark.normal.c.bg = "None"
        custom_onedark.inactive.c.bg = "None"

        local custom_horizon = require("lualine.themes.horizon")
        custom_horizon.normal.c.bg = "None"
        custom_horizon.inactive.c.bg = "None"

        -- Get current colorscheme to set as theme
        -- local current_theme = vim.g.colors_name or "auto"
        local tc = require("tokyocity.groups.plugins.lualine")
        return {
            options = {
                icons_enabled = true,
                theme = "auto",
                -- theme = custom_onedark,
                -- theme = "tokyonight",
                -- theme = "tokyonight-storm",
                -- theme = custom_horizon,
                -- theme = "ayu_dark",
                -- theme = "onedark",
                -- theme = "ayu_mirage"
                -- theme = "dracula"
                -- theme = "horizon"
                -- theme = "evangelion",
                -- Separators
                -- component_separators = { left = "░", right = "░" },
                -- section_separators = { left = "▓▒░", right = "░▒▓" },
                section_separators = tc.section_separators,
                component_separators = tc.component_separators,
            },
            sections = {
                lualine_a = { { "mode", icon = "" } },
                -- Use with evangelion theme
                -- lualine_b = {
                --     "branch",
                --     {
                --         "diff",
                --         colored = true,
                --         diff_color = {
                --             added = { fg = "#151515" },
                --             modified = { fg = "#151515" },
                --             removed = { fg = "#151515" },
                --         },
                --     },
                --     {
                --         "diagnostics",
                --         sources = { "nvim_diagnostic" },
                --         --         symbols = { error = " ", warn = " ", info = " " },
                --         diagnostics_color = {
                --             error = { fg = "#151515" },
                --             warn = { fg = "#151515" },
                --             info = { fg = "#151515" },
                --         },
                --     },
                -- },
            },
        }
    end,
    config = function(_, opts)
        require("lualine").setup(opts)
    end,
}
