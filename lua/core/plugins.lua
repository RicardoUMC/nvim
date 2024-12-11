local function bootstrap_pckr()
  local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

  if not (vim.uv or vim.loop).fs_stat(pckr_path) then
    vim.fn.system({
        'git',
        'clone',
        "--filter=blob:none",
        'https://github.com/lewis6991/pckr.nvim',
        pckr_path
      })
  end

  vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()

require('pckr').add{
  -- Temas
  'tinted-theming/base16-vim', 

  -- Plugins de interfaz
  'Yggdroot/indentLine',        -- Indentación visual
  'vim-airline/vim-airline',    -- Barra de estado
  'vim-airline/vim-airline-themes', -- Temas para vim-airline

  -- Plugins para productividad
  'mattn/emmet-vim',            -- Herramientas de diseño web
  --'preservim/nerdtree',         -- Gestor de archivos en árbol
  'christoomey/vim-tmux-navigator', -- Navegación entre ventanas tmux
  'jiangmiao/auto-pairs',       -- Autocompletado de paréntesis, llaves, etc.
  --'neoclide/coc.nvim', {  branch = 'release' }, -- Autocompletado inteligente
  'sheerun/vim-polyglot',       -- Soporte para múltiples lenguajes
  'ThePrimeagen/vim-be-good',   -- Entrenamiento para comandos de Vim
  'nvim-tree/nvim-tree.lua',
  'nvim-tree/nvim-web-devicons',
  'nvim-lualine/lualine.nvim',
  'nvim-treesitter/nvim-treesitter',
  'nvim-lua/plenary.nvim',
  'nvim-telescope/telescope.nvim', tag = '0.1.8', 

  -- Buscador rápido
  { 'junegunn/fzf', run = vim.fn['fzf#install'] },
  { 'neoclide/coc.nvim', branch = 'master', run = 'npm ci' },

  -- Otros plugins (puedes agregar más aquí)
  -- 'foo/bar.nvim';
}

