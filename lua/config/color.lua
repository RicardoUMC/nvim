local M = {}

local themes = {
    cyberdream = "cyberdream",
    horizon_dark = "base16-horizon-dark",
    tokyo_city_terminal_dark = "base16-tokyo-city-terminal-dark",
    tokyo_night_moon = "base16-tokyo-night-moon",
    kanagawa = "kanagawa",
}

function M.ColorMyPencils(color)
    color = color or vim.g.default_colorscheme or "tokyo_city_terminal_dark"

    if themes[color] then
        vim.cmd.colorscheme(themes[color])
    else
        print("Error: Colorscheme '" .. color .. "' not found!")
        return
    end

    -- Fondo transparente opcional
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

-- Comando para cambiar el tema desde Neovim
vim.api.nvim_create_user_command("ChangeColorscheme", function(opts)
    vim.g.default_colorscheme = opts.args
    M.ColorMyPencils(opts.args)
    print("Changing colorscheme to: " .. opts.args)
end, {
    nargs = 1,
    complete = function(arglead)
        local matches = {}
        for theme, _ in pairs(themes) do
            if theme:sub(1, #arglead) == arglead then
                table.insert(matches, theme)
            end
        end
        return matches
    end,
})

return M
