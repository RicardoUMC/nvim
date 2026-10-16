return {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    dependencies = {
        "smart-splits-nvim/backend-wezterm",
    },
    config = function()
        local smart_splits = require("smart-splits")

        smart_splits.setup({
            mux = {
                backend = "smart-splits-backend-wezterm",
            },
        })

        vim.keymap.set("n", "<C-h>", smart_splits.move_cursor_left, { desc = "Move to left split/pane" })
        vim.keymap.set("n", "<C-j>", smart_splits.move_cursor_down, { desc = "Move to lower split/pane" })
        vim.keymap.set("n", "<C-k>", smart_splits.move_cursor_up, { desc = "Move to upper split/pane" })
        vim.keymap.set("n", "<C-l>", smart_splits.move_cursor_right, { desc = "Move to right split/pane" })
    end,
}
