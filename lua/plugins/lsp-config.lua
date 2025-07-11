local capabilities = require("cmp_nvim_lsp").default_capabilities()

return {
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = { "lua_ls", "clangd" },
            automatic_installation = true,
        },
        dependencies = {
            {
                "mason-org/mason.nvim",
                opts = {},
            },
            {
                "neovim/nvim-lspconfig",
                opts = {
                    servers = {
                        angularls = {
                            cmd = {
                                "node",
                                "./node_modules/@angular/language-server/bin/ngserver",
                                "--stdio",
                                "--tsProbeLocations", "./node_modules",
                                "--ngProbeLocations", "./node_modules"
                            },
                            root_dir = function(fname)
                                return require("lspconfig.util").root_pattern("angular.json", "project.json")(fname)
                            end,
                            capabilities = capabilities,
                        },
                    },
                },
                config = function()
                    local lspconfig = require("lspconfig")

                    lspconfig.lua_ls.setup({
                        capabilities = capabilities,
                    })
                    lspconfig.rust_analyzer.setup({
                        capabilities = capabilities,
                        settings = {
                            ["rust-analyzer"] = {
                                inlayHints = {
                                    enable = true,
                                    parameterHints = { enable = true },
                                    typeHints = { enable = true },
                                },
                            },
                        },
                    })
                    lspconfig.clangd.setup({
                        capabilities = capabilities,
                    })
                    lspconfig.marksman.setup({
                        capabilities = capabilities,
                    })
                    lspconfig.markdown_oxide.setup({
                        capabilities = capabilities,
                    })

                    vim.api.nvim_create_autocmd("LspAttach", {
                        desc = "LSP actions",
                        callback = function(event)
                            local opts = { buffer = event.buf }

                            -- vim.lsp.inlay_hint.enable(true)
                            vim.keymap.set("n", "<leader>ih", function()
                                local enabled = vim.lsp.inlay_hint.is_enabled()
                                vim.lsp.inlay_hint.enable(not enabled)
                            end, { desc = "Toggle inlay hints" })

                            vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
                            vim.keymap.set("n", ",gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
                            vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
                            vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
                            vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
                            vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
                            vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
                            vim.keymap.set(
                                { "n", "x" },
                                "<F3>",
                                "<cmd>lua vim.lsp.buf.format({async = true})<cr>",
                                opts
                            )
                            vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
                        end,
                    })
                end,
            },
        },
    },
}
