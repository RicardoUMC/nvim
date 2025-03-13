return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				--theme = "ayu_dark"
				theme = "onedark",
				--theme = "ayu_mirage"
				--theme = "dracula"
				--theme = "horizon"
			},
		})
	end,
}
