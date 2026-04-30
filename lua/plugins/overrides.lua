return {
    {
        "folke/trouble.nvim",
        opts = { use_diagnostic_signs = true },
        cmd = "Trouble",
    },
    {
        "hedyhli/outline.nvim",
        config = function()
            vim.keymap.set("n", "<leader>O", "<cmd>Outline<CR>", { desc = "Toggle Outline" })

            require("outline").setup({})
        end,
    },
    -- {
    --     "nvim-mini/mini.nvim",
    --     version = false, -- Use the latest version
    --     config = function()
    --         require("mini.animate").setup({
    --             resize = {
    --                 enable = false,
    --             },
    --             open = {
    --                 enable = false,
    --             },
    --             close = {
    --                 enable = false,
    --             },
    --             scroll = {
    --                 enable = false,
    --             },
    --         })
    --     end,
    -- },
}
