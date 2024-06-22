return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    { 'antosha417/nvim-lsp-file-operations', config = true },
    'seblj/roslyn.nvim',
    'mrshmllow/document-color.nvim',
  },
  config = function()
    local lspconfig = require 'lspconfig'
    local mason_lspconfig = require 'mason-lspconfig'
    local cmp_nvim_lsp = require 'cmp_nvim_lsp'
    local document_color = require 'document-color'
    document_color.setup {}
    local capabilities = cmp_nvim_lsp.default_capabilities()
    local on_attach = function(client, bufnr)
      if client.server_capabilities.colorProvider then document_color.buf_attach(bufnr) end
    end
    capabilities.textDocument.colorProvider = {
      dynamicRegistration = true,
    }
    mason_lspconfig.setup_handlers { -- default handler for installed servers
      function(server_name)
        lspconfig[server_name].setup {
          capabilities = capabilities,
          on_attach = on_attach,
        }
      end,
      ['volar'] = function()
        lspconfig.volar.setup {
          capabilities = capabilities,
          on_attach = on_attach,
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
          on_attach = on_attach,
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
    }
    require('roslyn').setup { capabilities = capabilities, on_attach = on_attach }
    -- manual lsp config
    require('lspconfig').unocss.setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }
  end,
}
