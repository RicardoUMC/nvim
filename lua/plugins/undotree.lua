return {
    "mbbill/undotree",
    config = function()
        vim.keymap.set("n", "<leader>uU", vim.cmd.UndotreeToggle, { desc = "Toggle undotree" })
    end,
}
