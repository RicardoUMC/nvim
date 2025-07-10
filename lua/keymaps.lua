-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable arrows
vim.keymap.set("n", "<Up>", ":echoe 'Get off my lawn!'<CR>")
vim.keymap.set("n", "<Down>", ":echoe 'Get off my lawn!'<CR>")
vim.keymap.set("n", "<Left>", ":echoe 'Get off my lawn!'<CR>")
vim.keymap.set("n", "<Right>", ":echoe 'Get off my lawn!'<CR>")
vim.keymap.set("i", "<Up>", "<C-o>:echoe 'Get off my lawn!'<CR>")
vim.keymap.set("i", "<Down>", "<C-o>:echoe 'Get off my lawn!'<CR>")
vim.keymap.set("i", "<Left>", "<C-o>:echoe 'Get off my lawn!'<CR>")
vim.keymap.set("i", "<Right>", "<C-o>:echoe 'Get off my lawn!'<CR>")
vim.keymap.set("v", "<Up>", ":<C-u>echoe 'Get off my lawn!'<CR>")
vim.keymap.set("v", "<Down>", ":<C-u>echoe 'Get off my lawn!'<CR>")
vim.keymap.set("v", "<Left>", ":<C-u>echoe 'Get off my lawn!'<CR>")
vim.keymap.set("v", "<Right>", ":<C-u>echoe 'Get off my lawn!'<CR>")

-- Personalize mappings
vim.keymap.set("n", "<C-k>", "wincmd k<CR>")
vim.keymap.set("n", "<C-j>", "wincmd j<CR>")
vim.keymap.set("n", "<C-h>", "wincmd h<CR>")
vim.keymap.set("n", "<C-l>", "wincmd l<CR>")
vim.api.nvim_set_keymap("n", "<A-a>", "ggVG", { noremap = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "FileType" }, {
    callback = function()
        vim.opt_local.formatoptions:remove("o")
    end,
})

-- Suggested mappings
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "8jzz")
vim.keymap.set("n", "<C-u>", "8kzz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

--Delete all buffers but the current one
vim.keymap.set( "n", "<leader>bq", '<Esc>:%bdelete|edit #|normal`"<Return>', { desc = "Delete all buffers but the current one" })

-- Refine Ctrl-s to save with the custom function
vim.api.nvim_set_keymap("n", "<C-s>", ":lua SaveFile()<CR>", { noremap = true, silent = true })

-- Toggle hlsearch con <leader>h
vim.keymap.set("n", "<leader>h", function()
    local current = vim.o.hlsearch
    vim.o.hlsearch = not current
    print("Highlight search " .. (vim.o.hlsearch and "enabled" or "disabled"))
end, { desc = "Toggle search highlight" })

-- Toggle transparent background <leader>b
vim.keymap.set("n", "<leader>b", function()
    require("config.transparency").toggle()
    require("config.color").apply()
end, { desc = "Toggle transparent background" })

vim.keymap.set("x", "<leader>p", '"_dp')

vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

vim.keymap.set("n", "<leader>d", '"+d')
vim.keymap.set("v", "<leader>d", '"+d')

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>")

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
        vim.cmd("silent! write")          -- Try to save the file without showing the default message
    end)

    if success then
        vim.notify(filename .. " Saved!")                  -- Show only the custom message if successful
    else
        vim.notify("Error: " .. err, vim.log.levels.ERROR) -- Show the error message if it fails
    end
end
