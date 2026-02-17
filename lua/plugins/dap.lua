return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "theHamsta/nvim-dap-virtual-text",
        },
        keys = {
            {
                "<leader>dc",
                function()
                    require("dap").continue()
                end,
                desc = "DAP Continue",
            },
            {
                "<leader>do",
                function()
                    require("dap").step_over()
                end,
                desc = "DAP Step Over",
            },
            {
                "<leader>di",
                function()
                    require("dap").step_into()
                end,
                desc = "DAP Step Into",
            },
            {
                "<leader>dO",
                function()
                    require("dap").step_out()
                end,
                desc = "DAP Step Out",
            },
            {
                "<leader>db",
                function()
                    require("dap").toggle_breakpoint()
                end,
                desc = "DAP Toggle Breakpoint",
            },
            {
                "<leader>dB",
                function()
                    require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
                end,
                desc = "DAP Conditional Breakpoint",
            },
            {
                "<leader>dr",
                function()
                    require("dap").repl.open()
                end,
                desc = "DAP REPL",
            },
            {
                "<leader>dq",
                function()
                    require("dap").terminate()
                end,
                desc = "DAP Terminate",
            },
        },
        config = function(_, _)
            require("nvim-dap-virtual-text").setup()
        end,
    },

    -- Go: carga/configura solo en buffers Go
    {
        "leoluz/nvim-dap-go",
        ft = { "go", "gomod", "gowork" },
        dependencies = { "mfussenegger/nvim-dap", "mason-org/mason.nvim" },
        config = function()
            local ok, dapgo = pcall(require, "dap-go")
            if not ok then
                return
            end

            dapgo.setup({
                delve = {
                    path = vim.fn.exepath("dlv"),
                },
            })
        end,
    },

    -- Mason bridge para DAP (instala adapters por nombre)
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = { "mason-org/mason.nvim", "mfussenegger/nvim-dap" },
        event = "VeryLazy",
        cmd = { "DapInstall", "DapUninstall" },
        opts = {
            automatic_installation = true,

            -- Aquí solo se agregan lenguajes/adapters conforme se necesiten:
            ensure_installed = {
                -- "delve",     -- Go
                -- "python",    -- debugpy
                -- "codelldb",  -- Rust/C/C++
                -- "js",        -- depende de el entorno (ver nota abajo)
            },

            -- handlers permite “parchear” o extender configs por adapter
            handlers = {},
        },
        config = function(_, opts)
            require("mason-nvim-dap").setup(opts)
        end,
    },

    -- UI: nvim-dap-view
    {
        "igorlfs/nvim-dap-view",
        dependencies = { "mfussenegger/nvim-dap" },
        ---@module 'dap-view'
        ---@type dapview.Config
        opts = {},
        keys = {
            { "<leader>dt", "<cmd>DapViewToggle<cr>", desc = "DAP View Toggle" },
            { "<leader>dw", "<cmd>DapViewWatch<cr>", desc = "DAP View Watch" },
            { "<leader>dvo", "<cmd>DapViewOpen<cr>", desc = "DAP View Open" },
            { "<leader>dvc", "<cmd>DapViewClose<cr>", desc = "DAP View Close" },
        },
        config = function(_, opts)
            require("dap-view").setup(opts)

            vim.fn.sign_define(
                "DapBreakpoint",
                { text = "" } -- { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
            )
            vim.fn.sign_define("DapBreakpointCondition", { text = "" })
            vim.fn.sign_define("DapBreakpointRejected", { text = "󰅚" })
            vim.fn.sign_define("DapLogPoint", { text = "󰍹" })
            vim.fn.sign_define(
                "DapStopped",
                -- { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
                { text = "" }
            )

            local dap = require("dap")
            dap.listeners.after.event_initialized["dap-view"] = function()
                vim.cmd("DapViewOpen")
            end
            dap.listeners.before.event_terminated["dap-view"] = function()
                vim.cmd("DapViewClose")
            end
            dap.listeners.before.event_exited["dap-view"] = function()
                vim.cmd("DapViewClose")
            end
        end,
    },
}
