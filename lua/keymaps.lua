-- Mapeos personalizados
vim.api.nvim_set_keymap("i", "jk", "<ESC>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-M-Left>", "<C-w>h", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-M-Down>", "<C-w>j", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-M-Up>", "<C-w>k", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-M-Right>", "<C-w>l", { noremap = true })
vim.api.nvim_set_keymap("n", "<A-a>", "ggVG", { noremap = true })

-- Mapeos sugeridos
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

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
    local modes = { "n", "i", "v", "x", "t" } -- Modos: normal, insert, visual, select, terminal
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
