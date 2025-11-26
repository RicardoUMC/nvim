return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			local gs = require("gitsigns")
			gs.setup()

			vim.keymap.set("n", "<leader>gp", gs.preview_hunk, { desc = "Preview hunk" })
			vim.keymap.set("n", "<leader>gt", gs.toggle_current_line_blame, { desc = "Toggle current line blame" })
			vim.keymap.set({ "n", "v" }, "<leader>ga", gs.stage_hunk, { desc = "Stage hunk" })
			vim.keymap.set({ "n", "v" }, "<leader>gu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
		end,
	},
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
}
