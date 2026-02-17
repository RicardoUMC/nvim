return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            toggle = {
                enabled = true,
                which_key = true,
                notify = true,
            },
            input = {
                enabled = true,
            },
            picker = {
                enabled = true,
            },
            terminal = {
                enabled = true,
            },
            zen = {
                enabled = true,
            },
        },
        init = function()
            vim.api.nvim_create_autocmd("User", {
                pattern = "VeryLazy",
                callback = function()
                    -- <leader>s: Search (including TODO)
                    Snacks.keymap.set("n", "<leader>st", "<cmd>TodoTelescope<cr>", { desc = "TODO (Telescope)" })
                    Snacks.keymap.set("n", "<leader>sT", "<cmd>TodoTrouble<cr>", { desc = "TODO (Trouble)" })
                    Snacks.keymap.set("n", "<leader>sq", "<cmd>TodoQuickFix<cr>", { desc = "TODO (Quickfix)" })

                    -- <leader>u: UI toggles (LazyVim-style)
                    Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
                    Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
                    Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
                    Snacks.toggle.diagnostics():map("<leader>ud")
                    Snacks.toggle.line_number():map("<leader>ul")
                    Snacks.toggle.inlay_hints():map("<leader>uh")
                    Snacks.toggle.zen():map("<leader>uz")
                    Snacks.toggle.zoom():map("<leader>uZ")
                end,
            })
        end,
    },
}
