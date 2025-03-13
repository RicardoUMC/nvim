local function bootstrap_pckr()
	local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

	if not (vim.uv or vim.loop).fs_stat(pckr_path) then
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/lewis6991/pckr.nvim",
			pckr_path,
		})
	end

	vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()

require("pckr").add({
	-- Temas
	"tinted-theming/tinted-vim",

	-- Plugins de interfaz
	-- 'Yggdroot/indentLine',
	"vim-airline/vim-airline",
	"vim-airline/vim-airline-themes",
	"nvim-lualine/lualine.nvim",

	-- Plugins para productividad
	"mattn/emmet-vim",
	"christoomey/vim-tmux-navigator",
	"jiangmiao/auto-pairs",
	"sheerun/vim-polyglot",
	"ThePrimeagen/vim-be-good",
	"ThePrimeagen/harpoon",

	-- Explorador de archivos
	{
		"nvim-tree/nvim-tree.lua",
		requires = { "nvim-tree/nvim-web-devicons" },
	},

	-- Soporte para Git
	"lewis6991/gitsigns.nvim",
	"tpope/vim-fugitive",

	-- Sistema de deshacer avanzado
	"mbbill/undotree",

	-- LSP y autocompletado
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	"nvimtools/none-ls.nvim", -- Formatters & Linter
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/nvim-cmp",
	{
		"L3MON4D3/LuaSnip",
		requires = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},

	-- Alpha (pantalla de inicio)
	{
		"goolord/alpha-nvim",
		requires = {
			"nvim-tree/nvim-web-devicons",
			"nvim-lua/plenary.nvim",
		},
	},

	-- Explorador de archivos alternativo (Neo-tree)
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"3rd/image.nvim",
		},
	},

	-- Buscador rápido
	{
		"junegunn/fzf",
		run = vim.fn["fzf#install"],
	},

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		requires = { "nvim-lua/plenary.nvim" },
	},
	"nvim-telescope/telescope-ui-select.nvim",

	-- Treesitter para resaltado de sintaxis avanzado
	{
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	},
})
