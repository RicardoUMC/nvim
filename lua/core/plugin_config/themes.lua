-- Tema y colores
function ColorMyPencils(color)
    color = color or "base16-tokyo-city-terminal-dark"
    vim.cmd.colorscheme(color)

    -- optional for transparency
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

vim.o.termguicolors = true
vim.g.tinted_background_transparent = 1

ColorMyPencils()
