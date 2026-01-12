return {
    {
        "ThePrimeagen/vim-be-good",
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependicies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            local harpoon = require("harpoon")

            harpoon:setup()

            -- basic telescope configuration
            local conf = require("telescope.config").values
            local function toggle_telescope(harpoon_files)
                local file_paths = {}
                for _, item in ipairs(harpoon_files.items) do
                    table.insert(file_paths, item.value)
                end

                require("telescope.pickers")
                    .new({}, {
                        prompt_title = "Harpoon",
                        finder = require("telescope.finders").new_table({
                            results = file_paths,
                        }),
                        previewer = conf.file_previewer({}),
                        sorter = conf.generic_sorter({}),
                    })
                    :find()
            end

            vim.keymap.set("n", "<leader>ha", function()
                harpoon:list():add()
            end)
            vim.keymap.set("n", "<leader>h", function()
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end)
            vim.keymap.set("n", "<leader>ht", function()
                toggle_telescope(harpoon:list())
            end, { desc = "Open Harpoon Telescope" })

            vim.keymap.set("n", "<leader>h1", function()
                harpoon:list():select(1)
            end, { desc = "Go to harpoon 1" })
            vim.keymap.set("n", "<leader>h2", function()
                harpoon:list():select(2)
            end, { desc = "Go to harpoon 2" })
            vim.keymap.set("n", "<leader>h3", function()
                harpoon:list():select(3)
            end, { desc = "Go to harpoon 3" })
            vim.keymap.set("n", "<leader>h4", function()
                harpoon:list():select(4)
            end, { desc = "Go to harpoon 4" })
            vim.keymap.set("n", "<leader>h5", function()
                harpoon:list():select(5)
            end, { desc = "Go to harpoon 5" })
            vim.keymap.set("n", "<leader>h6", function()
                harpoon:list():select(6)
            end, { desc = "Go to harpoon 6" })
            vim.keymap.set("n", "<leader>h7", function()
                harpoon:list():select(7)
            end, { desc = "Go to harpoon 7" })
            vim.keymap.set("n", "<leader>h8", function()
                harpoon:list():select(8)
            end, { desc = "Go to harpoon 8" })
            vim.keymap.set("n", "<leader>h9", function()
                harpoon:list():select(9)
            end, { desc = "Go to harpoon 9" })
            vim.keymap.set("n", "<leader>h0", function()
                harpoon:list():select(0)
            end, { desc = "Go to harpoon 10" })

            -- Toggle previous & next buffers stored within Harpoon list
            vim.keymap.set("n", "<leader>hp", function()
                harpoon:list():prev()
            end, { desc = "Harpoon previous file" })
            vim.keymap.set("n", "<leader>hn", function()
                harpoon:list():next()
            end, { desc = "Harpoon next file" })
        end,
    },
}
