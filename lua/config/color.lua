-- lua/colorscheme.lua
local M = {}

local colorscheme_file = vim.fn.stdpath("config") .. "/colorscheme.txt"

local function read_colorscheme()
    local file = io.open(colorscheme_file, "r")
    if file then
        local color = file:read("*l")
        file:close()
        return color
    end
end

local function save_colorscheme(color)
    local file = io.open(colorscheme_file, "w")
    if file then
        file:write(color)
        file:close()
    else
        print("Error: Cannot save the colorscheme file in " .. colorscheme_file)
    end
end

local function get_hl(name)
    return vim.api.nvim_get_hl(0, { name = name, link = false }) or {}
end

function M.apply(color)
    color = color or read_colorscheme()

    if color then
        local ok, err = pcall(function()
            vim.cmd.colorscheme(color)
        end)
        if ok then
            save_colorscheme(color)
        else
            print("Error applying colorscheme:", err)
        end
    else
        print("Error: Colorscheme not found! Using default.")
    end

    local visual = get_hl("Visual")
    local cursorline = get_hl("CursorLine")
    local comment = get_hl("Comment")
    local funct = get_hl("Function")
    local type = get_hl("Type")
    local statement = get_hl("Statement")

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

    vim.api.nvim_set_hl(0, "LspInlayHint", {
        bg = cursorline.bg or visual.bg,
        fg = comment.fg or visual.fg,
        italic = true,
    })

    vim.api.nvim_set_hl(0, "Search", {
        bg = type.fg,
        fg = cursorline.bg or "#000000",
        bold = true,
    })

    vim.api.nvim_set_hl(0, "IncSearch", {
        bg = funct.fg or statement.fg or "#ff00ff",
        fg = cursorline.bg or "#000000",
        bold = true,
    })

    vim.api.nvim_set_hl(0, "CurSearch", {
        bg = funct.fg or visual.fg or "#ff00ff",
        fg = cursorline.bg,
        bold = true,
    })
end

return M
