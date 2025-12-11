return {
    {
        "mattn/emmet-vim",
    },
    {
        "stevearc/conform.nvim",
        opts = {
            format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
            formatters_by_ft = {
                html = { "prettierd" },
                typescript = { "prettierd" },
                javascript = { "prettierd" },
                css = { "prettierd" },
                scss = { "prettierd" },
                json = { "prettierd" },
                markdown = { "prettierd" },
                go = { "gofmt" },
                lua = { "stylua" },
                opts = {},
            },
            formatters = {
                stylua = {
                    args = { "--indent-type", "Spaces", "--indent-width", "4", "-" },
                },
            },
        },
    },
}
