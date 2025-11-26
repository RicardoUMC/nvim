return {
    "nvimtools/none-ls.nvim", -- Formatters & Linter
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua.with({
                    extra_args = { "--indent-type", "Spaces", "--indent-width", "4" },
                }),
                null_ls.builtins.formatting.prettier,
                null_ls.builtins.formatting.gofmt,
            },
        })

        vim.keymap.set({ "n", "v" }, "<leader>gf", vim.lsp.buf.format, { desc = "Format file/block" })
    end,
}
