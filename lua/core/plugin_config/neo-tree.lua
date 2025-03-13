require("neo-tree").setup({
    filesystem = {
        follow_current_file = true,
        use_libuv_file_watcher = true,
    },
    default_component_configs = {
        indent = {
            padding = 0,
            indent_size = 4,
        }
    }
})

vim.keymap.set("n", "<C-n>", ":Neotree<CR>", {})
