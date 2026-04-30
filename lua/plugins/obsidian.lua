return {
    "epwalsh/obsidian.nvim",
    version = "*",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        workspaces = {
            {
                name = "Obsidian",
                path = "~/obsidian",
            },
        },
        completion = {
            nvim_cmp = true,
            min_chars = 2,
        },
        notes_subdir = "universe",
        new_notes_location = "galaxies",
        attachments = {
            img_folder = "assets",
        },
        daily_notes = {
            template = "daily",
        },
        mappings = {
            ["gl"] = {
                action = function()
                    return require("obsidian").util.gf_passthrough()
                end,
                opts = { noremap = false, expr = true, buffer = true, desc = "Follow Obsidian link" },
            },
            ["ok"] = {
                action = "<cmd>ObsidianToggleCheckbox<CR>",
                opts = { buffer = true, desc = "Toggle checkbox in current line" },
            },
            ["<leader>oit"] = {
                action = "<cmd>ObsidianTemplate<CR>",
                opts = { buffer = true, desc = "Insert template" },
            },
        },
        note_frontmatter_func = function(note)
            local frontmatter = { id = note.id, aliases = note.aliases, tags = note.tags }
            if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
                for k, v in pairs(note.metadata) do
                    frontmatter[k] = v
                end
            end
            return frontmatter
        end,
        note_id_func = function(title)
            local suffix = ""
            if title ~= nil then
                suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
            else
                for _ = 1, 4 do
                    suffix = suffix .. string.char(math.random(65, 90))
                end
            end
            return tostring(os.time()) .. "-" .. suffix
        end,
        templates = {
            subdir = "templates",
            date_format = "%Y-%m-%d-%a",
            time_format = "%H:%M",
        },
        -- UI handled by render-markdown.nvim — disabling to avoid conflicts
        ui = { enable = false },
    },
    config = function(_, opts)
        require("obsidian").setup(opts)

        local obsidian_path = vim.fn.expand("~/obsidian")

        -- Helper: runs a command ensuring we're in the obsidian workspace,
        -- regardless of the current session or working directory.
        local function obsidian_cmd(cmd)
            return function()
                local cwd = vim.fn.getcwd()
                if not vim.startswith(vim.fn.fnamemodify(cwd, ":p"), vim.fn.fnamemodify(obsidian_path, ":p")) then
                    vim.cmd("cd " .. obsidian_path)
                end
                vim.cmd(cmd)
            end
        end

        -- Global keymaps — work from any session or directory
        vim.keymap.set("n", "<leader>on", obsidian_cmd("ObsidianNew"), { desc = "Obsidian: new note" })
        vim.keymap.set("n", "<leader>os", obsidian_cmd("ObsidianSearch"), { desc = "Obsidian: search notes" })
        vim.keymap.set("n", "<leader>oq", obsidian_cmd("ObsidianQuickSwitch"), { desc = "Obsidian: quick switch" })
        vim.keymap.set("n", "<leader>ob", obsidian_cmd("ObsidianBacklinks"), { desc = "Obsidian: backlinks" })
        vim.keymap.set("n", "<leader>ot", obsidian_cmd("ObsidianToday"), { desc = "Obsidian: today's daily note" })
    end,
}
