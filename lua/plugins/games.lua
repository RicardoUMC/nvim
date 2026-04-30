return {
    "tigion/games.nvim",
    opts = {
        window = {
            width = 0.9,
            height = 0.9,
            max = { width = 0, height = 0 },
            border = "rounded",
            ignore_34_aspect_ratio = true,
        },
    },
    config = function(_, opts)
        require("games").setup(opts)
    end,
    keys = {
        {
            "<leader>G",
            function()
                require("games").select()
            end,
            desc = "Open Games",
        },
    },
}
