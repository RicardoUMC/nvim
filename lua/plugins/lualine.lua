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

        return {
            options = {
                icons_enabled = true,
                theme = custom_onedark,
                -- theme = custom_horizon,
                -- theme = "ayu_dark"
                -- theme = "onedark",
                -- theme = "ayu_mirage"
                -- theme = "dracula"
                -- theme = "horizon"
            },
            sections = {
                lualine_a = { { "mode", icon = "" } },
            },
        }
    end,
    config = function(_, opts)
        require("lualine").setup(opts)
    end,
}
