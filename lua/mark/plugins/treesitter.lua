return {
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'windwp/nvim-ts-autotag',
  },
  config = function()
    -- import nvim-treesitter plugin
    local treesitter = require 'nvim-treesitter.configs'
    -- configure treesitter
    treesitter.setup { -- enable syntax highlighting
      highlight = {
        enable = true,
      },
      -- enable indentation
      indent = { enable = true },
      -- enable autotagging (w/ nvim-ts-autotag plugin)
      autotag = {
        enable = true,
      },
      -- ensure these language parsers are installed
      ensure_installed = {
        'json',
        'javascript',
        'typescript',
        'yaml',
        'html',
        'css',
        'markdown',
        'bash',
        'lua',
        'dockerfile',
        'gitignore',
        'c',
        'vue',
        'fish',
        'c_sharp'
      }
    }
  end,
}
