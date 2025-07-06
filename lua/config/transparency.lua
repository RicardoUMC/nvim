-- lua/transparency.lua
local M = {}

local transparency_file = vim.fn.stdpath("config") .. "/transparency.txt"

-- Leer estado de transparencia desde el archivo
local function read_transparency()
    local file = io.open(transparency_file, "r")
    if file then
        local value = file:read("*l")
        file:close()
        return value == "1"
    end
    return false
end

-- Guardar estado en el archivo
local function save_transparency(enabled)
    local file = io.open(transparency_file, "w")
    if file then
        file:write(enabled and "1" or "0")
        file:close()
    else
        print("Error: Cannot save transparency file to " .. transparency_file)
    end
end

-- Aplicar estado de transparencia
function M.apply()
    local enabled = read_transparency()
    if enabled then
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    else
        vim.api.nvim_set_hl(0, "Normal", { bg = nil })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = nil })
    end
    vim.g.tinted_background_transparent = enabled and 1 or 0
end

-- Toggle y guardar
function M.toggle()
    local new_state = not read_transparency()
    if new_state then
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    else
        vim.api.nvim_set_hl(0, "Normal", { bg = nil })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = nil })
    end
    vim.g.tinted_background_transparent = new_state and 1 or 0
    save_transparency(new_state)

    print(new_state and "🟢 Transparent background on" or "🔴 Transparent background off")
end

return M
