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
            indent = {
                enabled = true,
                indent = {
                    char = "│",
                },
                scope = {
                    enabled = true,
                    char = "│",
                    underline = false,
                },
                animate = {
                    enabled = vim.fn.has("nvim-0.10") == 1,
                    style = "out",
                    easing = "linear",
                    duration = {
                        step = 20,
                        total = 250,
                    },
                },
                filter = function(buf, _)
                    if vim.g.snacks_indent == false or vim.b[buf].snacks_indent == false then
                        return false
                    end
                    if vim.bo[buf].buftype ~= "" then
                        return false
                    end

                    local ft = vim.bo[buf].filetype
                    local exclude = {
                        ["Trouble"] = true,
                        ["alpha"] = true,
                        ["dashboard"] = true,
                        ["help"] = true,
                        ["lazy"] = true,
                        ["mason"] = true,
                        ["neo-tree"] = true,
                        ["notify"] = true,
                        ["snacks_dashboard"] = true,
                        ["snacks_notif"] = true,
                        ["snacks_terminal"] = true,
                        ["snacks_win"] = true,
                        ["toggleterm"] = true,
                        ["trouble"] = true,
                    }
                    return not exclude[ft]
                end,
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
                    Snacks.toggle.indent():map("<leader>ug")
                    Snacks.toggle.zen():map("<leader>uz")
                    Snacks.toggle.zoom():map("<leader>uZ")
                end,
            })
        end,
    },
}
