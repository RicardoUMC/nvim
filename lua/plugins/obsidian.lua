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
            ["<leader>of"] = {
                action = function()
                    return require("obsidian").util.gf_passthrough()
                end,
                opts = { noremap = false, expr = true, buffer = true, desc = "Follow Obsidian link" },
            },
            ["<leader>od"] = {
                action = "<cmd>ObsidianToggleCheckbox<CR>",
                opts = { buffer = true, desc = "Toggle checkbox in current line" },
            },
            ["<leader>on"] = {
                action = "<cmd>ObsidianNew<CR>",
                opts = { buffer = true, desc = "Create new note" },
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
    },
}
