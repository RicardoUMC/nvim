return {
	{
		"ThePrimeagen/vim-be-good",
	},
	{
		"ThePrimeagen/harpoon",
		dependicies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local mark = require("harpoon.mark")
			local ui = require("harpoon.ui")

			vim.keymap.set("n", "<leader>ha", mark.add_file, { desc = "Add file to harpoon" })
			vim.keymap.set("n", "<leader>h", ui.toggle_quick_menu, { desc = "Open harpoon list" })

			vim.keymap.set("n", "<leader>h1", function() ui.nav_file(1) end, { desc = "Go to harpoon 1" })
			vim.keymap.set("n", "<leader>h2", function() ui.nav_file(2) end, { desc = "Go to harpoon 2" })
			vim.keymap.set("n", "<leader>h3", function() ui.nav_file(3) end, { desc = "Go to harpoon 3" })
            vim.keymap.set("n", "<leader>h4", function() ui.nav_file(4) end, { desc = "Go to harpoon 4" })
            vim.keymap.set("n", "<leader>h5", function() ui.nav_file(5) end, { desc = "Go to harpoon 5" })
            vim.keymap.set("n", "<leader>h6", function() ui.nav_file(6) end, { desc = "Go to harpoon 6" })
            vim.keymap.set("n", "<leader>h7", function() ui.nav_file(7) end, { desc = "Go to harpoon 7" })
            vim.keymap.set("n", "<leader>h8", function() ui.nav_file(8) end, { desc = "Go to harpoon 8" })
            vim.keymap.set("n", "<leader>h9", function() ui.nav_file(9) end, { desc = "Go to harpoon 9" })
            vim.keymap.set("n", "<leader>h0", function() ui.nav_file(0) end, { desc = "Go to harpoon 10" })
		end,
	},
}
