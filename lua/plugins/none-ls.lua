return {
    "nvimtools/none-ls.nvim", -- Formatters & Linter
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua.with({
                    extra_args = { "--indent-type", "Spaces", "--indent-width", "4" },
                }),
                null_ls.builtins.formatting.prettierd,
                null_ls.builtins.formatting.gofmt,
            },
        })

        vim.keymap.set({ "n", "v" }, "<leader>gf", function()
            vim.lsp.buf.format({
                async = true,
                filter = function(client)
                    return client.name == "null-ls"
                end,
            })
        end, { desc = "Format file/block" })
    end,
}
