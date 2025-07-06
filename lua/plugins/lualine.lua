return {
    "nvim-lualine/lualine.nvim",
    config = function()
        local custom_onedark = require 'lualine.themes.onedark'
        custom_onedark.normal.c.bg = "None"
        custom_onedark.inactive.c.bg = "None"

        require("lualine").setup({
            options = {
                icons_enabled = true,
                theme = custom_onedark,
                -- theme = "ayu_dark"
                -- theme = "onedark",
                -- theme = "ayu_mirage"
                -- theme = "dracula"
                -- theme = "horizon"
            },
        })
    end,
}
