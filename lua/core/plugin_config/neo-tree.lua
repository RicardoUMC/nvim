require("neo-tree").setup({
    filesystem = {
        follow_current_file = true,
        use_libuv_file_watcher = true,
    },
})

vim.keymap.set("n", "<C-n>", ":Neotree<CR>", {})
