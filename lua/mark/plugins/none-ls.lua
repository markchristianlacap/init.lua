return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'davidmh/cspell.nvim',
  },
  config = function()
    local null_ls = require 'null-ls'
    local cspell = require 'cspell'
    --set up cspell
    null_ls.setup {
      sources = {
        -- cspell
        cspell.diagnostics.with {
          diagnostics_postprocess = function(diagnostic) diagnostic.severity = vim.diagnostic.severity['HINT'] end,
        },
        cspell.code_actions,
        --stylua
        null_ls.builtins.formatting.stylua,
      },
    }
  end,
}
