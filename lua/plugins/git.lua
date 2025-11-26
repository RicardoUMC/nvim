return {
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "Gmove", "Gdelete", "Gedit", "Glog" },
		keys = {
			{ "<leader>gd", ":Gdiffsplit<CR>", desc = "Git diff split" },
			{ "<leader>gl", ":vert leftabove Git log<CR>", desc = "Git log" },
			{ "<leader>gc", ":Git commit -m \"\"<Left>", desc = "Commit changes" },
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			local gs = require("gitsigns")
			gs.setup({ current_line_blame = true })

			vim.keymap.set("n", "<leader>gp", gs.preview_hunk, { desc = "Preview hunk" })
			vim.keymap.set({ "n", "v" }, "<leader>ga", gs.stage_hunk, { desc = "Stage hunk" })
			vim.keymap.set({ "n", "v" }, "<leader>gu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
            vim.keymap.set("n", "<leader>gb", gs.toggle_current_line_blame, { desc = "Toggle current line blame" })
            vim.keymap.set("n", "<leader>gtn", gs.toggle_numhl, { desc = "Toggle line number highlights" })
            vim.keymap.set("n", "<leader>gtl", gs.toggle_linehl, { desc = "Toggle highlighted lines" })
            vim.keymap.set("n", "gn", function() gs.next_hunk() end, { desc = "Go to next hunk" })
            vim.keymap.set("n", "gp", function() gs.prev_hunk() end, { desc = "Go to previous hunk" })

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
