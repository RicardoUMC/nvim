return {
    {
        "folke/flash.nvim",
        opts = {},
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
        -- PERF: Slow, needs optimize
        -- HACK: Only runs for TODO buffers
        -- TODO: Temporary patch, find solution
        -- NOTE: Add notes
        -- FIX:  This is a fix
        -- WARNING: Warning
        config = function(_, opts)
            require("todo-comments").setup(opts)
        end,
    },
    {
        "nvim-mini/mini.animate",
        version = "*",
        opts = function(_, opts)
            -- don't use animate when scrolling with the mouse
            local mouse_scrolled = false
            for _, scroll in ipairs({ "Up", "Down" }) do
                local key = "<ScrollWheel" .. scroll .. ">"
                vim.keymap.set({ "", "i" }, key, function()
                    mouse_scrolled = true
                    return key
                end, { expr = true })
            end

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "grug-far",
                callback = function()
                    vim.b.minianimate_disable = true
                end,
            })

            -- schedule setting the mapping to override the default mapping from `keymaps.lua`
            -- seems `keymaps.lua` is the last event to execute on `VeryLazy` and it overwrites it
            vim.schedule(function()
                Snacks.toggle({
                    name = "Mini Animate",
                    get = function()
                        return not vim.g.minianimate_disable
                    end,
                    set = function(state)
                        vim.g.minianimate_disable = not state
                    end,
                }):map("<leader>ua")
            end)

            local animate = require("mini.animate")
            return vim.tbl_deep_extend("force", opts, {
                resize = {
                    timing = animate.gen_timing.linear({ duration = 50, unit = "total" }),
                },
                scroll = {
                    timing = animate.gen_timing.linear({ duration = 50, unit = "total" }),
                    subscroll = animate.gen_subscroll.equal({
                        predicate = function(total_scroll)
                            if mouse_scrolled then
                                mouse_scrolled = false
                                return false
                            end
                            return total_scroll > 1
                        end,
                    }),
                },
            })
        end,
    },
    {
        "sphamba/smear-cursor.nvim",
        opts = {
            time_interval = 2,
            never_draw_over_target = true,
            stiffness = 0.8,
            trailing_stiffness = 0.5,
            stiffness_insert_mode = 0.7,
            trailing_stiffness_insert_mode = 0.7,
            matrix_pixel_threshold = 0.5,
            damping = 0.95,
            damping_insert_mode = 0.95,
            distance_stop_animating = 0.5,
            legacy_computing_symbols_support = true,
            distance_stop_animating_vertical_bar = 0.1,
        },
        config = function(_, opts)
            require("smear_cursor").setup(opts)
        end,
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

            -- theta.header.val = {
            --     [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⣤⣴⣶⣶⣾⣿⣿⣿⣿⣿⣿⣷⣶⣶⣦⣤⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            --     [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣴⣾⣿⣿⠿⠟⠛⠋⠉⠉⠉⠁⠀⠀⠈⠉⠉⠉⠙⠛⠻⠿⣿⣿⣷⣦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            --     [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣾⣿⡿⠟⠋⢁⣠⡤⠀⠀⠀⠀⢀⣤⣶⡶⠿⠷⣶⣤⡀⠀⠀⠀⠀⣄⡈⠙⠻⢿⣿⣷⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            --     [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⡿⠛⢁⣠⣴⠇⡿⢟⠃⠀⠀⠀⣰⣿⠋⠁⣀⣀⣀⠀⠉⢻⣆⠀⠀⠀⠸⢿⡇⢢⣄⡈⠛⢿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            --     [[⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⠟⠁⣠⣶⣿⠿⠋⠀⣾⣿⠀⠀⠀⢀⣿⡇⢠⡾⠋⠉⠉⢻⡄⢀⣩⡄⠀⠀⠀⣷⣦⠘⠿⣿⣶⣄⠈⠻⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀]],
            --     [[⠀⠀⠀⠀⠀⠀⣠⣾⣿⠟⠁⣠⣾⡿⠋⠁⠀⣠⡄⣿⣿⠀⠀⠀⠈⣩⡅⣤⣄⠀⠀⠀⢀⣤⡍⣉⠃⠀⠀⢠⣿⡇⣀⠀⠈⠙⢿⣷⣄⠈⠻⣿⣷⣄⠀⠀⠀⠀⠀⠀]],
            --     [[⠀⠀⠀⠀⠀⣴⣿⡿⠁⣠⣾⡿⠋⠀⢀⣴⣿⣿⣧⠹⣿⡆⠀⠀⠀⠹⣿⣝⡿⣶⣶⢢⡿⣟⣽⠏⠀⠀⠀⣼⣿⢁⣿⣿⣦⡀⠀⠙⢿⣷⣄⠈⢿⣿⣦⠀⠀⠀⠀⠀]],
            --     [[⠀⠀⠀⢀⣾⣿⠟⢀⣼⣿⠟⠀⢀⣴⣿⠏⠀⠀⠉⣆⠻⣿⣆⠀⠀⠀⠈⠛⠿⣷⢆⣶⠿⠛⠁⠀⠀⢀⣼⣿⢃⣬⡻⣿⣿⣿⣦⡀⠀⠻⣿⣧⡀⠻⣿⣷⡀⠀⠀⠀]],
            --     [[⠀⠀⢀⣾⣿⠏⢀⣾⡿⠃⠀⣠⣿⣿⣿⢆⡀⢀⣰⣿⣇⡙⢿⣷⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⠟⣡⣾⣿⣿⣮⡻⣿⣿⣿⣄⠀⠘⢿⣷⡀⠹⣿⣷⡀⠀⠀]],
            --     [[⠀⠀⣾⣿⠏⠀⢚⣉⣥⣤⠤⠤⠤⣤⣅⣉⠛⠿⣿⣿⠟⡈⣤⣍⠻⢿⣷⣦⣤⣤⣤⣤⣤⣶⣾⠿⢋⣡⢀⠻⣿⣿⡿⠟⠛⠈⠉⠉⠉⠀⠀⠈⠛⠳⠀⠹⣿⣷⠀⠀]],
            --     [[⠀⣸⣿⡟⠀⠞⠋⢁⣠⣤⣤⣤⣤⣤⣄⣉⠙⠳⣤⡁⠺⣷⢻⣿⣿⣶⣦⡍⢉⣉⣉⣉⣩⣥⣴⣾⣿⡟⣾⡷⠈⠁⠀⠀⠀⠀⣀⣀⣀⣀⣀⠀⠀⠀⠀⠀⢻⣿⣇⠀]],
            --     [[⢀⣿⣿⠁⢠⣶⣇⡿⠿⠛⠛⠛⠛⠛⠿⢿⣿⣦⣀⠙⢦⡈⢇⢿⣿⣿⣿⡇⢸⣿⣿⣿⣿⠁⠀⠈⠻⡸⠋⠀⠀⠀⣠⣴⣾⡿⠟⠛⠛⠉⠛⠛⠳⠠⣄⡀⠈⣿⣿⡀]],
            --     [[⢸⣿⡏⠀⡿⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠻⣿⣷⡀⠹⣆⠘⣿⣿⣿⡇⢸⣿⣿⣿⣿⣤⣀⣠⠂⠁⠀⠀⣠⣾⡿⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠀⢹⣿⡇]],
            --     [[⣾⣿⡇⠀⠁⠀⠀⣀⣴⣶⡞⣿⢗⣴⣤⡀⠀⠀⠈⢿⣿⡄⠸⣆⢹⣿⣿⣧⢸⣿⣿⣟⠉⢹⣿⡏⠀⠀⠀⣼⣿⠟⠀⠀⠀⣠⡴⢚⣛⣓⢙⠲⢤⡀⠀⠀⠀⢸⣿⣷]],
            --     [[⣿⣿⠇⠀⠀⠀⣴⣿⣿⠿⢛⡀⣉⣛⠻⣿⣆⠀⠀⠈⣿⣿⡀⢹⡀⢿⣿⣿⡀⣿⣿⣿⣿⣿⡿⠀⠀⠀⣸⣿⡟⠀⠀⢀⡾⢡⡾⣻⣭⣭⢘⡭⠶⣝⢆⠀⠀⠘⣿⣿]],
            --     [[⣿⣿⡆⠀⠀⢸⣿⣿⢃⣾⣿⣧⢻⣿⣿⣎⢻⡀⠀⠀⢸⣿⡇⢸⡇⠘⣿⣿⣧⠸⣿⣿⣿⣿⢳⠀⠀⠀⣿⣿⠁⠀⠀⣸⢡⡏⣾⣿⠟⠛⣾⣧⣤⠟⢸⡆⠀⢠⣿⣿]],
            --     [[⢿⣿⡇⠀⠀⢸⣿⡇⢸⣿⣿⡟⠈⠉⠻⣿⢸⠁⠀⠀⢸⣿⡇⢸⡇⣸⣹⣿⣿⣆⢻⣿⣿⣏⣿⠀⠀⠀⣿⣿⡀⠀⠀⢻⡘⣇⣿⠿⣀⣠⣾⣿⢳⡿⢸⠇⠀⢸⣿⡿]],
            --     [[⢸⣿⣇⠀⠀⠀⢛⣴⡘⣿⣿⣆⠀⠀⣰⠟⠌⠀⠀⢀⣿⣿⠁⣸⠁⢿⣧⢿⣿⣿⣆⠹⡿⣼⣿⡀⠀⠀⢹⣿⣇⠀⠀⠈⢧⡑⢦⣛⡿⠿⣛⣵⡿⣡⠟⠀⠀⣸⣿⡇]],
            --     [[⠈⣿⣿⡀⠀⠀⠀⠉⠻⠦⣝⣛⣛⠃⠁⠀⠀⠀⢀⣾⣿⠃⢠⠏⣸⣦⠻⡎⣿⣿⣿⣧⠐⢿⣿⣧⠀⠀⠀⢿⣿⣆⠀⠀⠀⠙⠶⣭⣙⣛⣩⡥⠞⠋⠀⠀⢀⣿⣿⠁]],
            --     [[⠀⢹⣿⣧⠀⢤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣴⣿⡿⠁⣰⠏⣰⣿⣿⣧⢹⡸⣿⣿⢏⣿⣆⠙⢿⣦⠀⠀⠀⠻⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⡏⠀]],
            --     [[⠀⠀⢿⣿⣆⠈⢿⣷⡠⣤⣤⣤⣤⣤⣶⣾⣿⠟⠋⣠⠞⢁⠸⢿⣿⣿⣿⡇⣧⢻⡟⠜⠉⠉⠛⢦⡙⠓⡀⠀⠀⠈⠙⠿⣷⣦⣤⣀⣀⣀⣀⢀⣤⡴⠀⣰⣿⡿⠀⠀]],
            --     [[⠀⠀⠈⢿⣿⣆⠀⠉⠑⠙⠛⠛⠛⠛⠋⣉⣠⡴⠚⣡⣴⣿⣿⣶⣭⣙⡛⠇⠹⠎⠁⠀⠀⠀⠀⠀⣴⣶⣤⣀⠀⠀⠀⠀⠀⠉⠉⠙⠛⠛⠉⠈⠀⠀⣰⣿⡿⠁⠀⠀]],
            --     [[⠀⠀⠀⠈⢿⣿⣦⠈⠛⠓⠒⠒⠒⠛⣋⣉⣤⣦⣛⢿⣿⣿⡿⠟⠛⠻⢿⡇⣿⢇⡰⣄⡀⠀⣀⣼⣿⣿⣿⣿⡿⣒⣤⣤⣀⣀⠀⠀⠀⠀⠀⠀⠀⣴⣿⡿⠁⠀⠀⠀]],
            --     [[⠀⠀⠀⠀⠀⠻⣿⣷⡄⠙⢿⣷⣄⠀⠈⠻⣿⣿⣿⣷⣮⡏⠀⠀⠀⠀⠀⠱⡟⣾⣷⢻⣿⣿⣿⣿⡿⢟⣻⣵⣾⣿⣿⣿⠟⠁⠀⣠⣾⡿⠋⢀⣾⣿⠟⠀⠀⠀⠀⠀]],
            --     [[⠀⠀⠀⠀⠀⠀⠙⢿⣿⣦⡀⠙⢿⣷⣤⡀⠀⠙⠻⢿⣿⡄⣴⣷⡆⠀⠀⢀⣙⣛⣛⣋⣯⣭⣽⣶⣾⣿⣿⣿⡿⠟⠋⠀⢀⣠⣾⡿⠋⢀⣴⣿⡿⠋⠀⠀⠀⠀⠀⠀]],
            --     [[⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣿⣦⡀⠙⠿⣿⣶⣄⡀⠀⠈⠑⠙⠛⠁⢀⣠⢦⣿⣿⣿⣿⡼⣿⣿⡿⠿⠟⠋⠁⠀⢀⣠⣶⣿⠿⠋⢀⣴⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀]],
            --     [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣿⣷⣤⡈⠙⠻⢿⣷⣦⣤⣀⡀⠀⠀⠀⠈⠉⠉⠉⠉⠁⠀⠀⠀⢀⣀⣤⣴⣾⣿⠟⠋⢁⣤⣾⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            --     [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⢿⣿⣷⣦⣄⡈⠙⠛⠿⠿⣿⣿⣶⣶⣶⣶⣶⣶⣶⣶⣿⣿⡿⠿⠛⠋⢁⣠⣴⣾⣿⡿⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            --     [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠻⢿⣿⣿⣶⣦⣤⣄⣀⣈⣉⡉⠉⠉⢉⣉⣁⣀⣠⣤⣴⣶⣿⣿⡿⠟⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            --     [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠙⠛⠻⠿⠿⢿⣿⣿⣿⣿⣿⣿⡿⠿⠿⠟⠛⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            -- }

            -- theta.header.val = {
            --     [[⠀⠀⠀⠀⢀⣤⣴⠻⠯⠿⠽⠟⠷⣲⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            --     [[⠀⠀⢀⣴⡻⠊⠁⠀⠀⠀⠀⠀⠀⠀⠙⢿⣖⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            --     [[⠀⢀⣾⠍⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⢻⣶⠀⠀⠀⢀⣠⣠⢴⡲⡞⠷⠿⠟⠟⠯⠿⠷⠾⡧⢶⡤⣄⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            --     [[⢠⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠠⠀⣿⢧⡖⡿⠙⠊⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠚⠹⢾⡦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            --     [[⣼⡏⠄⡐⠀⠄⡀⠀⠀⠀⠀⠀⠀⠠⠈⠄⡁⣿⡎⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠻⣶⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            --     [[⣿⡇⢂⠐⡈⠄⡀⢂⠁⠠⢀⠐⢈⠠⢈⠐⡀⡏⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢷⣦⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            --     [[⣿⡇⢌⡐⢀⠂⡐⠠⢈⠐⡀⠂⠄⠂⠄⢂⡰⠁⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠙⢾⣧⢴⣖⡶⠾⠽⠷⠺⣤⣆⣄⠀⠀⠀⠀]],
            --     [[⣿⡇⢆⡐⢂⠡⠠⢁⠂⠔⠠⠁⠌⡐⠈⠤⠂⠀⠀⠀⠀⢠⣴⣦⣤⡀⠀⠀⠀⠀⠀⠀⠀⢠⣾⠟⠛⢿⣦⠀⠀⠀⠀⠀⠀⠀⠀⠐⠀⡀⠫⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⢿⣦⡀⠀]],
            --     [[⢿⣗⠢⡘⢄⠢⠑⢂⠉⡄⠃⠌⡐⠠⢡⠃⠀⠀⠀⠀⢰⡿⠋⠀⠹⣷⡀⠀⠀⠀⠀⠀⠀⣼⡏⠀⠀⠈⢿⡇⠀⠀⠀⠀⠀⠀⠀⠄⠂⢀⠡⠑⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣳⡀]],
            --     [[⢸⣿⢠⠛⡄⢣⠘⠄⡘⢀⠣⠘⡀⢃⠇⠀⠀⠀⠀⠀⣼⡇⠀⠀⠀⣿⡇⠀⠀⠀⠀⠀⠀⣿⣧⠀⠀⠀⣼⣿⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠄⢃⠸⡀⠀⠀⠀⠀⠀⠀⠀⡀⠄⢿⣃]],
            --     [[⠈⣿⣇⠎⠴⣁⠎⡰⢁⢂⠂⠅⣰⠁⠀⠀⠀⠀⠀⠀⣿⣷⡀⠀⢠⣿⣿⠀⠀⠀⠀⠀⠀⣿⣿⣷⣤⣾⣿⣿⡀⠀⠀⠀⠀⠀⠐⠈⠀⠠⠈⠄⢂⠱⠀⠀⠀⠀⠀⠠⠐⢀⠰⢸⣿]],
            --     [[⠀⢸⣿⡘⢆⠥⢊⡑⣂⠆⡌⠰⠁⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⡅⠀⠀⠀⠀⠀⡀⠀⠂⢁⠈⡐⠈⢆⢣⠀⠀⢀⠂⢀⠂⠄⢢⣹⢿]],
            --     [[⠀⠀⢻⣿⠨⣌⠣⢜⠠⢎⠌⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠐⠈⡀⠐⠠⢉⠰⡘⡄⠂⠠⠐⠠⡈⠜⡄⣿⠏]],
            --     [[⠀⠀⠀⢿⣷⢠⢋⢦⠝⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⢿⣿⡿⠀⠀⠀⢠⠀⡌⣀⠂⢁⠠⠁⢌⢂⠱⣈⢧⠈⡄⢡⢃⡜⠱⣾⡿⠀]],
            --     [[⠀⠀⠀⠀⢿⡷⢊⠡⢀⠀⠀⠀⠀⠀⠀⢀⠀⡀⠀⠀⠀⠹⣿⣿⣽⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠙⠿⠿⠟⠁⠀⠠⣉⠦⡙⠴⣡⠚⣄⢂⠡⠂⡌⠒⣌⢺⡔⣌⢣⠒⣬⣿⠛⠀⠀]],
            --     [[⠀⠀⠀⠀⢸⣟⠠⣁⠂⠀⠄⠀⡀⢦⡙⣌⢣⡑⢣⠆⠀⠀⠈⠉⠉⠁⠀⢀⣠⣤⣴⣤⣤⣤⣀⠀⠀⠀⠀⠀⠀⠠⠑⢎⡱⢃⠦⡙⠴⠈⡄⠣⢌⡱⢌⡖⡎⣔⣪⣿⠿⠋⠀⠀⠀]],
            --     [[⠀⠀⠀⠀⢸⣯⠐⠤⡁⢂⠀⢀⠘⢢⠱⡌⠦⡙⠢⠁⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⢿⣿⣿⣿⡆⠀⠀⠀⢀⠐⠠⢈⠠⢀⠡⢂⠁⢆⠱⣀⠣⢒⡜⣢⢝⣶⡿⠛⠁⠀⠀⠀⠀⠀]],
            --     [[⠀⠀⠀⠀⠘⣿⡉⢆⠱⡀⠠⠀⢀⠂⠁⠈⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣳⢯⣟⡾⣽⡟⠀⠀⢀⠐⠠⢈⠐⡀⠆⡌⢰⡈⣜⣤⣣⣴⣩⣖⣾⣵⣾⣿⡁⠀⠀⠀⠀⠀⠀⠀]],
            --     [[⠀⠀⠀⠀⠀⣿⣗⠌⡆⠱⡀⠡⠀⠠⠐⠀⠠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠻⣿⢾⠿⠋⠀⠀⡐⠠⢈⡐⠄⡊⣔⣸⡴⣷⣻⡽⣞⣷⢫⡗⣯⢞⡳⣯⣟⣿⣦⡀⠀⠀⠀⠀⠀]],
            --     [[⠀⠀⠀⠀⠀⠸⣿⡘⣌⠱⡠⢁⠌⡐⠀⠌⢀⠐⠈⠀⠐⠀⠄⠀⠠⠀⠀⠄⠀⠀⠀⢀⠀⠠⠐⢠⠀⠅⢢⠐⣬⣵⣟⣷⣻⠷⣏⡿⣽⢎⡷⣹⢆⣯⣳⡽⣞⣷⣻⣿⣆⠀⠀⠀⠀]],
            --     [[⠀⠀⠀⠀⠀⠀⢻⣷⢨⡑⢦⡁⢆⠠⠁⠌⡀⠂⠌⡀⢁⠂⠠⠈⡀⠐⠠⠐⢈⠠⠁⠄⡈⠄⠡⢂⡘⢌⣦⣿⣻⢾⡽⣾⢽⣻⣽⣛⣧⣟⡷⣯⣞⡷⣯⢿⡽⣞⣷⣻⣿⡀⠀⠀⠀]],
            --     [[⠀⠀⠀⠀⠀⠀⠀⢿⣧⠜⣢⠑⣎⠰⡁⠆⢄⠡⢂⠐⠠⠈⠄⠡⢀⠁⢂⠁⠂⠄⣁⠢⢐⠨⡁⢦⣘⣾⣳⢯⣟⣯⢿⡽⣯⢷⣯⣟⡾⣽⢯⡷⣯⢿⡽⣯⢿⡽⣞⡷⣿⡇⠀⠀⠀]],
            --     [[⠀⠀⠀⠀⠀⠀⠀⠀⠻⣿⡔⡍⣆⢣⡑⢎⡐⢂⠆⡌⢡⠘⢠⢁⠢⠌⡀⠎⡈⠔⡠⢂⠅⣢⢑⣦⢿⣳⢯⣟⡾⣽⢯⡿⣽⣻⢾⣽⣻⡽⣯⢿⡽⣯⢿⡽⣯⢿⡽⣯⣿⠁⠀⠀⠀]],
            --     [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿⣜⣆⠳⡜⣢⠙⡆⢎⠴⡁⢎⡐⢢⢁⠎⡰⢡⡘⠤⡱⢌⡜⢤⣫⣟⣯⣟⡿⣾⡽⣯⢿⣽⣳⢯⣟⣾⣳⢿⡽⣯⢿⡽⣯⢿⡽⣯⣟⣿⠟⠀⠀⠀⠀]],
            --     [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣟⡷⣍⠶⣡⢛⡜⢎⡲⢍⢦⡙⢆⠎⡜⣡⢆⡱⢣⡑⣎⡜⣲⣟⣾⣳⢯⣟⣷⣻⣽⣻⢾⣽⣻⣞⡷⣯⢿⡽⣯⢿⡽⣯⢿⣽⣳⣿⠟⠀⠀⠀⠀⠀]],
            --     [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⢘⣿⣽⣻⡽⣷⣇⡯⣜⢣⡝⣎⠶⣩⢎⡽⡸⢥⡚⡼⣡⢳⡜⣼⢳⣟⡾⣽⣻⣞⣷⣻⢾⣽⣻⣞⡷⣯⢿⡽⣯⢿⡽⣯⢿⣽⣻⣾⡿⠃⠀⠀⠀⠀⠀⠀]],
            --     [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣞⣷⣻⢷⣯⣟⣮⢷⣸⢬⢳⡱⣎⢶⣙⠶⣙⢶⣙⠶⣹⢎⡿⢯⣟⣷⣻⣞⡷⣯⣟⣾⣳⢯⡿⣽⢯⡿⣽⢯⡿⣽⣻⣞⣿⡟⠁⠀⠀⠀⠀⠀⠀⠀]],
            --     [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣾⣽⢻⣾⣽⡞⣿⣯⣿⣶⣷⡜⡎⣮⡝⣭⡞⡜⢫⣵⡎⡟⣿⡞⣷⢻⣾⣽⢳⡟⣾⣽⣯⣿⣽⣯⣿⣽⣯⡟⣷⣿⣿⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            --     [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⢾⣽⣻⣞⣷⣻⢷⣻⢾⡽⣯⣿⣟⣷⡷⣷⣾⣭⣧⣷⣼⣷⣯⡿⣽⣻⢾⡽⣯⣟⣷⣻⣞⣷⣻⣞⣷⣻⢾⣽⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            --     [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣟⣾⣳⣟⡾⣽⣫⣟⣯⣟⣷⣻⢾⣳⣿⣻⣞⡷⣟⣾⢷⣿⣿⣿⣷⢯⡿⣽⣳⣟⣾⣳⣟⣾⣳⢟⣮⣷⡿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            --     [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣞⡷⣯⣟⡷⣽⣚⢶⡻⣼⢯⡿⣽⣞⡷⣟⡿⣯⣟⣯⣿⣟⠈⠻⣿⣿⣵⣻⣞⣳⣟⣼⣷⣿⡿⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            --     [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⣾⣽⣳⡟⣾⢧⣏⠷⣹⢎⡷⣛⡷⣯⢿⣽⣻⢷⣯⢷⣿⣏⠀⠀⠀⠉⠉⠙⠛⠛⠛⠋⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            --     [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢻⣾⣳⢿⣽⡺⡼⣍⢧⡻⣜⢯⡷⢯⣟⡾⣽⣻⣞⣯⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            --     [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣟⡿⣶⣻⢗⣯⢾⡵⣯⣟⣾⣻⢾⣽⣳⣟⡾⣽⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            --     [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣷⣯⣟⡾⣯⣟⡷⣞⡷⣯⣟⣾⣳⢯⣿⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            --     [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠻⣾⣽⣷⢯⡿⣽⣻⢷⣻⢾⣽⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            --     [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠛⠿⢿⣷⣿⣿⣿⡿⠿⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
            -- }

            local dashboard = require("alpha.themes.dashboard")
            theta.buttons.val = {
                { type = "text", val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
                { type = "padding", val = 1 },
                dashboard.button("e", "  New file", "<cmd>ene<CR>"),
                dashboard.button("SPC SPC", "󱋡  Recently opened files"),
                dashboard.button("SPC f f", "󰈞  Find file"),
                dashboard.button("SPC f w", "󰈬  Find word"),
                dashboard.button("SPC o s", "  Open session"),
                dashboard.button("SPC l s", "  Open last session"),
                dashboard.button("u", "  Update plugins", "<cmd>Lazy sync<CR>"),
                dashboard.button("q", "  Quit", "<cmd>qa<CR>"),
            }

            alpha.setup(theta.config)
        end,
    },
    {
        "b0o/incline.nvim",
        event = "BufReadPre", -- Load this plugin before reading a buffer
        priority = 1200, -- Set the priority for loading this plugin
        config = function()
            require("incline").setup({
                window = { margin = { vertical = 0, horizontal = 1 } }, -- Set the window margin
                hide = {
                    cursorline = true, -- Hide the incline window when the cursorline is active
                },
                render = function(props)
                    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t") -- Get the filename
                    if vim.bo[props.buf].modified then
                        filename = "[+] " .. filename -- Indicate if the file is modified
                    end

                    local icon, color = require("nvim-web-devicons").get_icon_color(filename) -- Get the icon and color for the file
                    return { { icon, guifg = color }, { " " }, { filename } } -- Return the rendered content
                end,
            })
        end,
    },
}
