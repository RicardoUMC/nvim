local function get_probe_dir(root_dir)
    local project_root = vim.fs.dirname(vim.fs.find("node_modules", { path = root_dir, upward = true })[1])

    return project_root and (project_root .. "/node_modules") or ""
end

local function get_angular_core_version(root_dir)
    local project_root = vim.fs.dirname(vim.fs.find("node_modules", { path = root_dir, upward = true })[1])

    if not project_root then
        return ""
    end

    local package_json = project_root .. "/package.json"
    if not vim.uv.fs_stat(package_json) then
        return ""
    end

    local contents = io.open(package_json):read("*a")
    local json = vim.json.decode(contents)
    if not json.dependencies then
        return ""
    end

    local angular_core_version = json.dependencies["@angular/core"]

    angular_core_version = angular_core_version and angular_core_version:match("%d+%.%d+%.%d+")

    return angular_core_version
end

local function find_node_modules(root)
    local util = require("lspconfig.util")
    local join = util.path.join
    local candidates = {
        join(root, "node_modules"),
        join(root, "..", "node_modules"),
        join(root, "..", "..", "node_modules"),
    }
    for _, p in ipairs(candidates) do
        if vim.uv.fs_stat(p) then
            return p
        end
    end
    return join(root, "node_modules")
end

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
                config = function()
                    vim.api.nvim_create_autocmd("LspAttach", {

                        desc = "LSP actions",
                        callback = function(event)
                            local client = vim.lsp.get_client_by_id(event.data.client_id)
                            if not client then
                                return
                            end

                            -- 🔴 Desactivar formateo de angularls (y si quieres también de html, ts_ls, etc.)
                            if client.name == "angularls" or client.name == "html" then
                                client.server_capabilities.documentFormattingProvider = false
                                client.server_capabilities.documentRangeFormattingProvider = false
                            end

                            local name = vim.api.nvim_buf_get_name(event.buf)
                            if name:sub(1, 9) == "fugitive:" then
                                return
                            end
                            vim.lsp.inlay_hint.enable(true)
                            vim.keymap.set("n", "<leader>i", function()
                                local enabled = vim.lsp.inlay_hint.is_enabled()
                                vim.lsp.inlay_hint.enable(not enabled)
                                if enabled then
                                    print("🔴 Inlay hints disabled")
                                else
                                    print("🟢 Inlay hints enabled")
                                end
                            end, { desc = "Toggle inlay hints" })

                            vim.keymap.set(
                                "n",
                                "K",
                                vim.lsp.buf.hover,
                                { desc = "Show hover information", buffer = event.buf }
                            )
                            vim.keymap.set(
                                "n",
                                "gd",
                                vim.lsp.buf.definition,
                                { desc = "Go to definition", buffer = event.buf }
                            )
                            vim.keymap.set(
                                "n",
                                "gD",
                                vim.lsp.buf.declaration,
                                { desc = "Go to declaration", buffer = event.buf }
                            )
                            vim.keymap.set(
                                "n",
                                "gi",
                                vim.lsp.buf.implementation,
                                { desc = "Go to implementation", buffer = event.buf }
                            )
                            vim.keymap.set(
                                "n",
                                "gr",
                                vim.lsp.buf.references,
                                { desc = "List references", buffer = event.buf }
                            )
                            vim.keymap.set(
                                "n",
                                "<leader>rn",
                                vim.lsp.buf.rename,
                                { desc = "Rename symbol", buffer = event.buf }
                            )
                            vim.keymap.set(
                                "n",
                                "<leader>ca",
                                vim.lsp.buf.code_action,
                                { desc = "Show code actions", buffer = event.buf }
                            )
                        end,
                    })

                    vim.diagnostic.config({
                        virtual_text = true,
                        signs = true,
                        underline = true,
                        update_in_insert = false,
                        severity_sort = true,
                    })

                    local capabilities = require("cmp_nvim_lsp").default_capabilities()
                    local util = require("lspconfig.util")

                    local default_probe_dir = get_probe_dir(vim.fn.getcwd())
                    local default_angular_core_version = get_angular_core_version(vim.fn.getcwd())
                    local default_angular_root_dir = util.root_pattern("angular.json")(vim.fn.getcwd())
                    local root = vim.loop.cwd():gsub("\\", "/")
                    local nm = find_node_modules(root)
                    local ngserver = util.path.join(nm, "@angular", "language-server", "bin", "ngserver")

                    vim.lsp.config("angularls", {
                        capabilities = capabilities,
                        root_dir = default_angular_root_dir,
                        cmd = {
                            "node",
                            ngserver,
                            "--stdio",
                            "--tsProbeLocations",
                            default_probe_dir,
                            "--ngProbeLocations",
                            default_probe_dir,
                            "--angularCoreVersion",
                            default_angular_core_version,
                        },
                    })
                    vim.lsp.enable("angularls")
                    vim.lsp.config("ts_ls", {
                        root_dir = function(bufnr, on_dir)
                            local name = vim.api.nvim_buf_get_name(bufnr)
                            if name:sub(1, 9) == "fugitive:" then
                                return
                            end
                            local go_root = vim.fs.root(bufnr, { "go.work", "go.mod", ".git" })
                            if go_root then
                                return on_dir(go_root)
                            end
                        end,
                    })
                    vim.lsp.enable("ts_ls")
                    vim.lsp.config("lua_ls", {
                        capabilities = capabilities,
                        root_dir = function(bufnr, on_dir)
                            local name = vim.api.nvim_buf_get_name(bufnr)
                            if name:sub(1, 9) == "fugitive:" then
                                return
                            end
                            local go_root = vim.fs.root(bufnr, { "go.work", "go.mod", ".git" })
                            if go_root then
                                return on_dir(go_root)
                            end
                        end,
                    })
                    vim.lsp.enable("lua_ls")
                    vim.lsp.config("clangd", { capabilities = capabilities })
                    vim.lsp.enable("clangd")
                    vim.lsp.config("gopls", {
                        capabilities = capabilities,
                        root_dir = function(bufnr, on_dir)
                            local name = vim.api.nvim_buf_get_name(bufnr)
                            if name:sub(1, 9) == "fugitive:" then
                                return
                            end
                            local go_root = vim.fs.root(bufnr, { "go.work", "go.mod", ".git" })
                            if go_root then
                                return on_dir(go_root)
                            end
                        end,
                    })
                    vim.lsp.enable("gopls")
                    vim.lsp.config("marksman", { capabilities = capabilities })
                    vim.lsp.enable("marksman")
                    vim.lsp.config("markdown_oxide", { capabilities = capabilities })
                    vim.lsp.enable("markdown_oxide")
                    vim.lsp.config("rust_analyzer", {
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
                    vim.lsp.enable("rust_analyzer")
                end,
            },
        },
    },
}
