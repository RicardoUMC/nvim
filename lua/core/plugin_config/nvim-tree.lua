vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup()

require("nvim-tree").setup({
    renderer = {
      icons = {
        glyphs = {
          default = "",
          symlink = "",
          bookmark = "󰆤",
          modified = "●",
          hidden = "󰜌",
          folder = {
            arrow_closed = "",
            arrow_open = "",
            default = "",
            open = "",
            empty = "",
            empty_open = "",
            symlink = "",
            symlink_open = "",
          },
          git = {
            unstaged = "✗",
            staged = "✓",
            unmerged = "",
            renamed = "➜",
            untracked = "★",
            deleted = "",
            ignored = "◌",
          },
        },
      },
    },
    actions = {
      open_file = {
        quit_on_open = true,
        eject = true,
        resize_window = true,
        relative_path = true,
      },
    },
  })

  vim.keymap.set('n', '<c-n>', ':NvimTreeToggle<CR>')

