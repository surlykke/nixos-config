return {
  {
    'disrupted/one.nvim',
    config = function()
      -- vim.cmd 'colorscheme one'
    end,
  },
  {
    'justinmk/molokai',
    lazy = false,
    priorty = 1000,
    config = function()
      -- vim.cmd 'colorscheme molokai'
    end,
  },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priorty = 1000,
    config = function()
      vim.cmd 'colorscheme tokyonight-night'
    end,
  },
  {
    'lifepillar/vim-solarized8',
    lazy = false,
    priorty = 1000,
    config = function()
      -- vim.cmd 'colorscheme solarized8_high'
    end,
  },
  {
    'vague2k/vague.nvim',
    config = function()
      -- vim.cmd 'colorscheme vague'
    end,
  },
}
