return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    { 'antosha417/nvim-lsp-file-operations', config = true },
  },
  config = function()
    -- import lspconfig plugin
    local lspconfig = require 'lspconfig'

    -- import mason_lspconfig plugin
    local mason_lspconfig = require 'mason-lspconfig'

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require 'cmp_nvim_lsp'
    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()
    mason_lspconfig.setup_handlers {
      -- default handler for installed servers
      function(server_name)
        lspconfig[server_name].setup {
          capabilities = capabilities,
        }
      end,
      ['volar'] = function()
        lspconfig.volar.setup {
          capabilities = capabilities,
          init_options = {
            vue = {
              hybridMode = false,
            },
          },
        }
      end,
      ['vtsls'] = function()
        lspconfig.vtsls.setup {
          capabilities = capabilities,
          settings = {
            vtsls = {
              tsserver = {
                globalPlugins = {
                  {
                    name = '@vue/typescript-plugin',
                    location = require('mason-registry').get_package('vue-language-server'):get_install_path()
                      .. '/node_modules/@vue/language-server',
                    languages = { 'vue' },
                    configNamespace = 'typescript',
                    enableForWorkspaceTypeScriptVersions = true,
                  },
                },
              },
            },
          },
        }
      end,
      ['omnisharp'] = function()
        local omnisharp_path = require('mason-registry').get_package('omnisharp'):get_install_path()
          .. '/libexec/OmniSharp.dll'
        lspconfig.omnisharp.setup {
          capabilities = capabilities,
          cmd = { 'dotnet', omnisharp_path },
        }
      end,
    }
  end,
}
