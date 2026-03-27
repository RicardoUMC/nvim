-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Exit insert mode with '<C-c>'" })

-- Disable arrows
vim.keymap.set("n", "<Up>", "<nop>")
vim.keymap.set("n", "<Down>", "<nop>")
vim.keymap.set("n", "<Left>", "<nop>")
vim.keymap.set("n", "<Right>", "<nop>")
vim.keymap.set("v", "<Up>", "<nop>")
vim.keymap.set("v", "<Down>", "<nop>")
vim.keymap.set("v", "<Left>", "<nop>")
vim.keymap.set("v", "<Right>", "<nop>")

-- Personalize mappings
vim.keymap.set("n", "<C-k>", "wincmd k<CR>")
vim.keymap.set("n", "<C-j>", "wincmd j<CR>")
vim.keymap.set("n", "<C-h>", "wincmd h<CR>")
vim.keymap.set("n", "<C-l>", "wincmd l<CR>")
vim.keymap.set("n", "<A-a>", "ggVG")

-- Suggested mappings
vim.keymap.set("n", "<PageDown>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<PageUp>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<PageDown>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<PageUp>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "8j")
vim.keymap.set("n", "<C-u>", "8k")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader><leader>", ":Lazy<CR>", { desc = "Open Lazy" })

vim.keymap.set(
    "n",
    "<leader>bq",
    '<Esc>:%bdelete|edit #|normal`"<Return>',
    { desc = "Delete all buffers but the current one" }
)

vim.keymap.set("n", "<leader>t", function()
    require("config.transparency").toggle()
    require("config.color").apply()
end, { desc = "Toggle transparent background" })

vim.keymap.set("n", "<leader>TR", function()
    for k in pairs(package.loaded) do
        if k:match("^tokyocity") then package.loaded[k] = nil end
    end
    vim.cmd("colorscheme tokyocity")
    vim.notify("tokyocity reloaded", vim.log.levels.INFO)
end, { desc = "Reload tokyocity colorscheme" })

vim.api.nvim_set_keymap("n", "<C-s>", ":lua SaveFile()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-s><C-s>", ":lua SaveAllFiles()<CR>", { noremap = true, silent = true })

vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without replacing the default register" })
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>d", '"+d', { desc = "Delete to system clipboard" })

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

vim.keymap.set(
    "n",
    "<leader>r",
    ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
    { desc = "Replace all ocurrences of a word" }
)
vim.keymap.set(
    "v",
    "<leader>r",
    "y:%s/<C-r>=escape(@\",'/\\')<CR>/<C-r>=escape(@\",'/\\')<CR>/gI<Left><Left><Left>",
    { desc = "Replace all ocurrences of selected text" }
)
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { desc = "Change file permissions to executable" })

function CheckKeymapConflicts()
    local modes = { "n", "i", "v", "x", "t" } -- Modes: normal, insert, visual, select, terminal
    local conflicts = {}

    for _, mode in ipairs(modes) do
        local maps = vim.api.nvim_get_keymap(mode)
        local keymap_table = {}

        for _, map in ipairs(maps) do
            if keymap_table[map.lhs] then
                table.insert(conflicts, {
                    mode = mode,
                    key = map.lhs,
                    from = keymap_table[map.lhs].desc or keymap_table[map.lhs].callback,
                    new = map.desc or map.callback,
                })
            end
            keymap_table[map.lhs] = map
        end
    end

    if #conflicts > 0 then
        print("⚠️ Keymap conflicts detected:")
        for _, conflict in ipairs(conflicts) do
            print(
                string.format(
                    "Mode '%s': %s | Existing: %s | New: %s",
                    conflict.mode,
                    conflict.key,
                    conflict.from,
                    conflict.new
                )
            )
        end
    else
        print("✅ No keymap conflicts found")
    end
end

-- Custom save function
function SaveFile()
    -- Check if a buffer with a file is open
    if vim.fn.empty(vim.fn.expand("%:t")) == 1 then
        vim.notify("No file to save", vim.log.levels.WARN)
        return
    end

    local filename = vim.fn.expand("%:t") -- Get only the filename
    local success, err = pcall(function()
        vim.cmd("silent! write") -- Try to save the file without showing the default message
    end)

    if success then
        vim.notify(filename .. " Saved!") -- Show only the custom message if successful
    else
        vim.notify("Error: " .. err, vim.log.levels.ERROR) -- Show the error message if it fails
    end
end

-- Custom save all function
function SaveAllFiles()
    local success, err = pcall(function()
        vim.cmd("silent! wall") -- Save all open files without showing the default message
    end)

    if success then
        vim.notify("All files saved!") -- Show a custom message if successful
    else
        vim.notify("Error: " .. err, vim.log.levels.ERROR) -- Show the error message if it fails
    end
end
