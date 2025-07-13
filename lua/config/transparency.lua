-- lua/config/transparency.lua
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

function M.set_tinted_bg_transparent()
    local enabled = read_transparency()
    vim.g.tinted_background_transparent = enabled and 1 or 0
end

function M.set_hl_transarent()
    local enabled = read_transparency()
    if enabled then
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end
end

-- Toggle y guardar
function M.toggle()
    local new_state = not read_transparency()
    save_transparency(new_state)
    if new_state then
        print("🟢 Fondo transparente habilitado")
    else
        print("🔴 Fondo transparente deshabilitado")
    end
end

return M
