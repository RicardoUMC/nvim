return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("neo-tree").setup({
                filesystem = {
                    follow_current_file = {
                        enabled = true,
                    },
                    use_libuv_file_watcher = true,
                },
                window = {
                    mappings = {
                        ["P"] = {
                            "toggle_preview",
                            config = {
                                use_image_nvim = true,
                                title = "Neo-tree Preview",
                            },
                        },
                    },
                },
                event_handlers = {
                    {
                        event = "file_opened",
                        handler = function()
                            -- Cierra Neo-tree después de abrir un archivo
                            require("neo-tree.command").execute({ action = "close" })
                        end,
                    },
                },
            })

            vim.keymap.set("n", "<C-n>", ":Neotree reveal toggle=true<CR>", {})
        end,
    },
}
