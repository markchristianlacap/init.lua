return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
  },
  config = function()
    -- import mason
    local mason = require 'mason'

    -- import mason-lspconfig
    local mason_lspconfig = require 'mason-lspconfig'

    -- enable mason and configure icons
    mason.setup {}

    mason_lspconfig.setup {
      -- list of servers for mason to install
      ensure_installed = {
        'html',
        'cssls',
        'emmet_ls',
        'eslint',
        'volar',
        'intelephense',
        'lua_ls',
        'vtsls',
        'omnisharp'
      },
    }
  end,
}
