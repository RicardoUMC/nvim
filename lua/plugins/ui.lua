return {
    {
        "sphamba/smear-cursor.nvim",
        opts = {},
    },
    {
        "goolord/alpha-nvim",
        requires = {
            "nvim-tree/nvim-web-devicons",
            "nvim-lua/plenary.nvim",
        },
        config = function()
            local alpha = require("alpha")

            local theta = require("alpha.themes.theta")
            theta.header.val = {
                [[                                                                       ]],
                [[                                                                       ]],
                [[                                                                       ]],
                [[                                                                       ]],
                [[                                                                     ]],
                [[       ████ ██████           █████      ██                     ]],
                [[      ███████████             █████                             ]],
                [[      █████████ ███████████████████ ███   ███████████   ]],
                [[     █████████  ███    █████████████ █████ ██████████████   ]],
                [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
                [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
                [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
                [[                                                                       ]],
                [[                                                                       ]],
                [[                                                                       ]],
            }

            local dashboard = require("alpha.themes.dashboard")
            theta.buttons.val = {
                { type = "text",    val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
                { type = "padding", val = 1 },
                dashboard.button("e", "  New file", "<cmd>ene<CR>"),
                dashboard.button("SPC SPC", "󱋡  Recently opened files"),
                dashboard.button("SPC f f", "󰈞  Find file"),
                dashboard.button("SPC f w", "󰈬  Find word"),
                dashboard.button("SPC o s", "  Open session"),
                dashboard.button("SPC l s", "  Open last session"),
                dashboard.button("u", "  Update plugins", "<cmd>Lazy update<CR>"),
                dashboard.button("q", "  Quit", "<cmd>qa<CR>"),
            }

            alpha.setup(theta.config)
        end,
    },
    {
        "b0o/incline.nvim",
        event = "BufReadPre", -- Load this plugin before reading a buffer
        priority = 1200,      -- Set the priority for loading this plugin
        config = function()
            require("incline").setup({
                window = { margin = { vertical = 0, horizontal = 1 } }, -- Set the window margin
                hide = {
                    cursorline = true,                                  -- Hide the incline window when the cursorline is active
                },
                render = function(props)
                    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t") -- Get the filename
                    if vim.bo[props.buf].modified then
                        filename = "[+] " .. filename                                               -- Indicate if the file is modified
                    end

                    local icon, color = require("nvim-web-devicons").get_icon_color(filename) -- Get the icon and color for the file
                    return { { icon, guifg = color }, { " " }, { filename } }                 -- Return the rendered content
                end,
            })
        end,
    },
}
