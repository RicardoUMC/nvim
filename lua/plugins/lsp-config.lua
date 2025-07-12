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
                        lua_ls = {
                            capabilities = capabilities,
                        },
                        clangd = {
                            capabilities = capabilities,
                        },
                        marksman = {
                            capabilities = capabilities,
                        },
                        markdown_oxide = {
                            capabilities = capabilities,
                        },
                        angularls = {
                            capabilities = capabilities,
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
                        },
                        rust_analyzer = {
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
                        },
                    },
                },
                config = function()
                    vim.api.nvim_create_autocmd("LspAttach", {
                        desc = "LSP actions",
                        callback = function(event)
                            local opts = { buffer = event.buf }

                            -- vim.lsp.inlay_hint.enable(true)
                            vim.keymap.set("n", "<leader>i", function()
                                local enabled = vim.lsp.inlay_hint.is_enabled()
                                vim.lsp.inlay_hint.enable(not enabled)
                            end, { desc = "Toggle inlay hints" })

                            vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
                            vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
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
