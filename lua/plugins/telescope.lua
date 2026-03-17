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
                -- pickers = {
                --     find_files = {
                --         hidden = true,
                --     },
                --     grep_string = {
                --         additional_args = { "--hidden" }
                --     },
                --     live_grep = {
                --         additional_args = { "--hidden" }
                --     },
                -- },
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })
            telescope.load_extension("ui-select")

            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
            vim.keymap.set("n", "<leader>fF", function()
                builtin.find_files({ no_ignore = true, hidden = true })
            end, { desc = "Find Files (Hidden)" })
            vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "Find Git Files" })
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find Help Tags" })
            vim.keymap.set("n", "<leader>fw", function()
                builtin.grep_string({ search = vim.fn.input("Grep String: ") })
            end, { desc = "Find word" })
            vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Recent Files" })
            vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Search Live Grep" })
            vim.keymap.set("n", "<leader>sG", function()
                builtin.live_grep({ additional_args = { "--no-ignore", "--hidden" } })
            end, { desc = "Search Live Grep (Hidden)" })

            -- Colorscheme Configuration
            vim.keymap.set("n", "<leader>cs", function()
                local ok_color, colorscheme_util = pcall(require, "config.color")
                if not ok_color then
                    print("Error loading config.color:", colorscheme_util)
                    return
                end

                local ok_transparency, transparency_util = pcall(require, "config.transparency")
                if not ok_transparency then
                    print("Error loading config.transparency:", transparency_util)
                    return
                end

                local actions = require("telescope.actions")
                local action_state = require("telescope.actions.state")
                local pickers = require("telescope.pickers")
                local finders = require("telescope.finders")
                local conf = require("telescope.config").values
                local theme = require("telescope.themes").get_dropdown({
                    previewer = true,
                    layout_strategy = "horizontal",
                    layout_config = {
                        width = 0.7,
                        height = 0.9,
                        preview_cutoff = 20,
                        prompt_position = "top",
                        preview_width = 0.6,
                    },
                    prompt_title = false,
                })

                local previewed = nil

                local function preview()
                    local entry = action_state.get_selected_entry()
                    transparency_util.set_tinted_bg_transparent()
                    if entry and entry.value and entry.value ~= previewed then
                        vim.cmd.colorscheme(entry.value)
                        previewed = entry.value
                    end
                    transparency_util.set_hl_transarent()
                end

                pickers
                    .new(theme, {
                        prompt_title = "Live Colorscheme Preview",
                        finder = finders.new_table({
                            results = vim.fn.getcompletion("", "color"),
                        }),
                        sorter = conf.generic_sorter({}),
                        attach_mappings = function(prompt_bufnr, map)
                            map({ "n", "i" }, "<Tab>", function()
                                actions.move_selection_next(prompt_bufnr)
                                preview()
                            end)
                            map({ "n", "i" }, "<S-Tab>", function()
                                actions.move_selection_previous(prompt_bufnr)
                                preview()
                            end)
                            map("i", "<C-n>", function()
                                actions.move_selection_next(prompt_bufnr)
                                preview()
                            end)
                            map("i", "<C-p>", function()
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
                        previewer = require("telescope.previewers").new_buffer_previewer({
                            define_preview = function(self)
                                preview()
                                local Path = require("plenary.path")
                                local filepath = Path:new(vim.fn.stdpath("config"), "colorscheme_preview.md").filename
                                local ok, lines = pcall(vim.fn.readfile, filepath)
                                if ok and lines then
                                    vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
                                    vim.api.nvim_buf_set_option(self.state.bufnr, "filetype", "lua")
                                    vim.cmd("syntax enable")
                                else
                                    vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, {
                                        "Error reading file: " .. filepath,
                                    })
                                end
                            end,
                        }),
                    })
                    :find()
            end, { desc = "Telescope Colorscheme Live Preview" })
        end,
    },
}
