if vim.g.vscode then return {} end
return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
    "davidmh/cspell.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local cspell = require "cspell"
    local null_ls = require "null-ls"
    null_ls.setup {
      sources = {
        cspell.diagnostics,
        cspell.code_actions,
        require "none-ls.diagnostics.eslint_d",
        require "none-ls.formatting.eslint_d",
        null_ls.builtins.formatting.csharpier
      },
    }
  end,
}