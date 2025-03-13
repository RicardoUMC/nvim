return {
	-- Buscador rápido
	{
		"junegunn/fzf",
		build = vim.fn["fzf#install"],
		lazy = false,
	},
}
