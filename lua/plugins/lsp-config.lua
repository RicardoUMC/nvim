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
                            root_dir = function(fname)
                                return require("lspconfig.util").root_pattern("angular.json", "project.json")(fname)
                            end,
                        },
                    },
                },
                config = function()
                    local lspconfig_defaults = require("lspconfig").util.default_config
                    lspconfig_defaults.capabilities = vim.tbl_deep_extend(
                        "force",
                        lspconfig_defaults.capabilities,
                        require("cmp_nvim_lsp").default_capabilities()
                    )

                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup({
                        capabilities = lspconfig_defaults.capabilities,
                    })
                    lspconfig.rust_analyzer.setup({
                        capabilities = lspconfig_defaults.capabilities,
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
                        capabilities = lspconfig_defaults.capabilities,
                    })
                    lspconfig.marksman.setup({
                        capabilities = lspconfig_defaults.capabilities,
                    })
                    lspconfig.markdown_oxide.setup({
                        capabilities = lspconfig_defaults.capabilities,
                    })
                    lspconfig.angularls.setup({
                        capabilities = lspconfig_defaults.capabilities,
                    })

                    vim.api.nvim_create_autocmd("LspAttach", {
                        desc = "LSP actions",
                        callback = function(event)
                            local opts = { buffer = event.buf }

                            -- vim.lsp.inlay_hint.enable(true)
                            vim.keymap.set("n", "<leader>th", function()
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
