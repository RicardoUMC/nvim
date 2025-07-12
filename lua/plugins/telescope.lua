return {
    {
        "nvim-telescope/telescope-ui-select.nvim",
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local builtin = require("telescope.builtin")
            local telescope = require("telescope")

            telescope.setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })
            telescope.load_extension("ui-select")

            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
            vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "Find Git Files" })
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find Help Tags" })
            vim.keymap.set("n", "<leader>fw", function()
                builtin.grep_string({ search = vim.fn.input("Grep String: ") })
            end, { desc = "Find word" })
            vim.keymap.set("n", "<leader><leader>", builtin.oldfiles, { desc = "Recent Files" })
            vim.keymap.set("n", "<leader>s", builtin.live_grep, { desc = "Search Live Grep" })

           -- Colorscheme Configuration
            vim.keymap.set("n", "<leader>cs", function()
                local ok, colorscheme_util = pcall(require, "config.color")
                if not ok then
                    print("Error loading config.color:", colorscheme_util)
                    return
                end

                local actions = require("telescope.actions")
                local action_state = require("telescope.actions.state")
                local pickers = require("telescope.pickers")
                local finders = require("telescope.finders")
                local conf = require("telescope.config").values
                local theme = require("telescope.themes").get_dropdown({
                    previewer = false,
                    width = 0.4,
                    prompt_title = false,
                })

                local previewed = nil

                pickers
                    .new(theme, {
                        prompt_title = "Live Colorscheme Preview",
                        finder = finders.new_table({
                            results = vim.fn.getcompletion("", "color"),
                        }),
                        sorter = conf.generic_sorter({}),
                        attach_mappings = function(prompt_bufnr, map)
                            local function preview()
                                local entry = action_state.get_selected_entry()
                                if entry and entry.value and entry.value ~= previewed then
                                    vim.cmd.colorscheme(entry.value)
                                    previewed = entry.value
                                end
                            end

                            map({ "n", "i" }, "<Tab>", function()
                                actions.move_selection_next(prompt_bufnr)
                                preview()
                            end)
                            map({ "n", "i" }, "<S-Tab>", function()
                                actions.move_selection_previous(prompt_bufnr)
                                preview()
                            end)
                            map("i", "<C-j>", function()
                                actions.move_selection_next(prompt_bufnr)
                                preview()
                            end)
                            map("i", "<C-k>", function()
                                actions.move_selection_previous(prompt_bufnr)
                                preview()
                            end)
                            map("n", "j", function()
                                actions.move_selection_next(prompt_bufnr)
                                preview()
                            end)
                            map("n", "k", function()
                                actions.move_selection_previous(prompt_bufnr)
                                preview()
                            end)

                            local function select_and_save()
                                local entry = action_state.get_selected_entry()
                                if entry and entry.value then
                                    actions.close(prompt_bufnr)
                                    colorscheme_util.apply(entry.value)
                                    print("Colorscheme changed to: " .. entry.value)
                                end
                            end

                            map("n", "<Esc>", function()
                                colorscheme_util.apply()
                                actions.close(prompt_bufnr)
                            end)
                            map("n", "q", function()
                                colorscheme_util.apply()
                                actions.close(prompt_bufnr)
                            end)
                            map({ "n", "i" }, "<C-c>", function()
                                colorscheme_util.apply()
                                actions.close(prompt_bufnr)
                            end)
                            map({ "n", "i" }, "<CR>", select_and_save)

                            return true
                        end,
                        previewer = false,
                    })
                    :find()
            end, { desc = "Telescope Colorscheme Live Preview" })
        end,
    },
}
