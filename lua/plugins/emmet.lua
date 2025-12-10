return {
    {
        "mattn/emmet-vim",
    },
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                html = { "prettierd" },
                typescript = { "prettierd" },
                javascript = { "prettierd" },
                css = { "prettierd" },
                scss = { "prettierd" },
                json = { "prettierd" },
                markdown = { "prettierd" },
                go = { "gofmt" },
            },
            format_on_save = { timeout_ms = 500, lsp_fallback = true },
        },
    },
}
