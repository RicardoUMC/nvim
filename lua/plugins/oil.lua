return {
    'stevearc/oil.nvim',
    opts = {
        vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open Oil in current directory" }),
        vim.keymap.set("n", "<leader>-", "<cmd>Oil --float<CR>", { desc = "Open floating Oil in current directory" }),
        columns = {
            "icon",
            -- "permissions",
        },
        float = {
            -- preview_split: Split direction: "auto", "left", "right", "above", "below".
            preview_split = "right",
        },
    },
    -- Optional dependencies
    -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
}
