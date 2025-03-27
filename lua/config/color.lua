local themes = {
    cyberdream = "cyberdream",
    horizon_dark = "base16-horizon-dark",
    tokyo_city_terminal_dark = "base16-tokyo-city-terminal-dark",
    tokyo_night_moon = "base16-tokyo-night-moon",
    kanagawa = "kanagawa",
}

local theme_lookup = {}
for key, value in pairs(themes) do
    theme_lookup[value] = key
end

local default_colorscheme = {
    name = theme_lookup[themes.tokyo_city_terminal_dark],
    value = themes.tokyo_city_terminal_dark,
}

local colorscheme_file = vim.fn.stdpath("config") .. "/colorscheme.txt"

local function read_colorscheme()
    local file = io.open(colorscheme_file, "r")
    if file then
        local color = file:read("*l")
        file:close()
        return themes[color] and color or nil
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

function ColorMyPencils(color)
    color = color or read_colorscheme()

    if themes[color] then
        vim.cmd.colorscheme(themes[color])
        save_colorscheme(color)
    else
        print("Error: Colorscheme not found! Using default.")
        vim.cmd.colorscheme(default_colorscheme.value)
        save_colorscheme(default_colorscheme.name)
    end

    -- Optional for transparecy
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

vim.api.nvim_create_user_command("ChangeColorscheme", function(opts)
    ColorMyPencils(opts.args)
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

ColorMyPencils()
