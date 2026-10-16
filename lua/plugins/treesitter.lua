return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        build = ":TSUpdate",
        config = function()
            -- Prefer GitHub tarballs over Git clones on Linux/macOS. This avoids
            -- stale or incomplete Git remotes in parser download directories.
            require("nvim-treesitter.install").prefer_git = false

            require("nvim-treesitter.configs").setup({
                -- A list of parser names, or "all" (the listed parsers MUST always be installed)
                ensure_installed = {
                    "rust",
                    "c",
                    "lua",
                    "javascript",
                    "typescript",
                    "python",
                    "vim",
                    "vimdoc",
                    "query",
                    "markdown",
                    "markdown_inline",
                },
                sync_install = false,

                -- Install missing parsers when entering a supported filetype.
                auto_install = true,

                highlight = {
                    -- `false` will disable the whole extension
                    enable = true,

                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
                    -- Instead of true it can also be a list of languages
                    additional_vim_regex_highlighting = true,
                },

                indent = {
                    enable = true,
                },
            })
        end,
    },
}
