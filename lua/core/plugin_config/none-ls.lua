local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.ast_grep,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.diagnostics.ast_grep,
		null_ls.builtins.diagnostics.cpplint,
		null_ls.builtins.diagnostics.bacon,
		null_ls.builtins.diagnostics.eslint_d,
	},
})

vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
