return {
    {
        "yetone/avante.nvim",
        -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
        -- ⚠️ must add this setting! ! !
        branch = "main",
        build = vim.fn.has("win32") ~= 0
                and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
            or "make",
        event = "VeryLazy",
        version = false, -- Never set this value to "*"! Never!
        ---@module 'avante'
        ---@type avante.Config
        opts = {
            -- add any opts here
            -- for example
            windows = {},
            provider = "copilot", -- default provider
            behaviour = {
                auto_approve_tool_permissions = false,
                confirmation_ui_style = "popup", -- u otro estilo que muestre confirmación
                auto_focus_sidebar = true,
                auto_suggestions = false, -- Experimental stage
                auto_suggestions_respect_ignore = true,
                auto_set_highlight_group = true,
                auto_set_keymaps = true,
                auto_apply_diff_after_generation = true,
                jump_result_buffer_on_finish = false,
                support_paste_from_clipboard = false,
                minimize_diff = true,
                enable_token_counting = true,
                use_cwd_as_project_root = false,
                auto_focus_on_diff_view = false,
            },
            providers = {
                copilot = {
                    -- endpoint = "https://api.githubcopilot.com",
                    model = "gpt-4",
                },
                claude = {
                    endpoint = "https://api.anthropic.com",
                    model = "claude-sonnet-4-20250514",
                    timeout = 30000, -- Timeout in milliseconds
                    extra_request_body = {
                        temperature = 0.75,
                        max_tokens = 20480,
                    },
                },
                moonshot = {
                    endpoint = "https://api.moonshot.ai/v1",
                    model = "kimi-k2-0711-preview",
                    timeout = 30000, -- Timeout in milliseconds
                    extra_request_body = {
                        temperature = 0.75,
                        max_tokens = 32768,
                    },
                },
            },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            --- The below dependencies are optional,
            "nvim-mini/mini.pick", -- for file_selector provider mini.pick
            "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
            "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
            "ibhagwan/fzf-lua", -- for file_selector provider fzf
            "stevearc/dressing.nvim", -- for input provider dressing
            "folke/snacks.nvim", -- for input provider snacks
            "nvim-mini/mini.icons", -- or nvim-tree/nvim-web-devicons
            "zbirenbaum/copilot.lua", -- for providers='copilot'
            {
                -- support for image pasting
                "HakonHarnes/img-clip.nvim",
                event = "VeryLazy",
                opts = {
                    -- recommended settings
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = {
                            insert_mode = true,
                        },
                        -- required for Windows users
                        use_absolute_path = true,
                    },
                },
            },
        },
    },
    {
        "NickvanDyke/opencode.nvim",
        dependencies = {
            -- Recommended for `ask()` and `select()`.
            -- Required for `snacks` provider.
            ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
            { "folke/snacks.nvim" },
        },
        config = function()
            ---@type opencode.Opts
            vim.g.opencode_opts = {
                -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
            }

            -- Required for `opts.events.reload`.
            vim.o.autoread = true

            -- Recommended/example keymaps.
            vim.keymap.set({ "n", "x" }, "<leader>oa", function()
                require("opencode").ask("@this: ", { submit = true })
            end, { desc = "Ask opencode" })
            vim.keymap.set({ "n", "x" }, "<leader>ox", function()
                require("opencode").select()
            end, { desc = "Execute opencode action…" })
            vim.keymap.set({ "n", "t" }, "<leader>ot", function()
                require("opencode").toggle()
            end, { desc = "Toggle opencode" })

            vim.keymap.set({ "n", "x" }, "go", function()
                return require("opencode").operator("@this ")
            end, { expr = true, desc = "Add range to opencode" })
            vim.keymap.set("n", "goo", function()
                return require("opencode").operator("@this ") .. "_"
            end, { expr = true, desc = "Add line to opencode" })

            vim.keymap.set("n", "<S-C-u>", function()
                require("opencode").command("session.half.page.up")
            end, { desc = "opencode half page up" })
            vim.keymap.set("n", "<S-C-d>", function()
                require("opencode").command("session.half.page.down")
            end, { desc = "opencode half page down" })

            -- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o".
            -- vim.keymap.set("n", "+", "<C-a>", { desc = "Increment", noremap = true })
            -- vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement", noremap = true })
        end,
    },
}
