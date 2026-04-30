return {
    "Shatur/neovim-session-manager",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local config = require("session_manager.config")
        require("session_manager").setup({
            autoload_mode = {
                config.AutoloadMode.GitSession,
                config.AutoloadMode.Disabled,
                config.AutoloadMode.LastSession,
                config.AutoloadMode.CurrentDir,
            },
        })
        vim.keymap.set("n", "<leader>sl", ":SessionManager load_last_session<CR>", { desc = "Load last session" })
        vim.keymap.set("n", "<leader>ss", ":SessionManager load_session<CR>", { desc = "Load session (picker)" })
        vim.keymap.set("n", "<leader>sd", ":SessionManager delete_session<CR>", { desc = "Delete session" })
        vim.keymap.set("n", "<leader>sw", ":SessionManager save_current_session<CR>", { desc = "Save current session" })
    end,
}
