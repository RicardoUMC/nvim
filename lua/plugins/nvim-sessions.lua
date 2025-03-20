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
		vim.keymap.set("n", "<leader>ls", ":SessionManager load_last_session<CR>", {})
		vim.keymap.set("n", "<leader>os", ":SessionManager load_session<CR>", {})
	end,
}
