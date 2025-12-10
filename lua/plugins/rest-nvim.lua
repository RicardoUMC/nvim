return {
    {
        "rest-nvim/rest.nvim",
        enabled = false,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-telescope/telescope.nvim",
            -- opts = function(_, opts)
            --     opts.ensure_installed = opts.ensure_installed or {}
            --     table.insert(opts.ensure_installed, "http")
            -- end,
        },
        config = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "http",
                callback = function()
                    require("utils.rest_bridge").use_vscode_rest_env("multipagos")
                    pcall(function()
                        require("telescope").load_extension("rest")
                    end)
                end,
            })

            local map = function(mode, lhs, rhs, opts)
                vim.api.nvim_create_autocmd("FileType", {
                    pattern = "http",
                    callback = function()
                        vim.keymap.set(mode, lhs, rhs, opts)
                    end,
                })
            end

            map("n", "<leader>Rr", "<cmd>Rest run<CR>", { desc = "Run REST request" })
            map("n", "<leader>Rl", "<cmd>Rest last<CR>", { desc = "Run last REST request" })
            map("n", "<leader>Re", function()
                pcall(function()
                    require("telescope").extensions.rest.select_env()
                end)
            end, { desc = "Select REST environment" })
        end,
    },
    {
        "mistweaverco/kulala.nvim",
        keys = {
            { "<leader>Rs", desc = "Send request" },
            { "<leader>Ra", desc = "Send all requests" },
            { "<leader>Rb", desc = "Open scratchpad" },
        },
        ft = { "http", "rest" },
        opts = {
            global_keymaps = true,
            global_keymaps_prefix = "<leader>R",
            kulala_keymaps_prefix = "",
        },
    },
}
