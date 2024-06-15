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
    -- Function to setup the language server and formatting
    local on_attach = function(client, bufnr)
      -- Check if the LSP client is Volar, if so, skip formatting
      if client.name == "volar" then
        return
      end
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("LspFormatting", { clear = true }),
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { async = false }
        end,
      })
    end
    mason_lspconfig.setup_handlers({
      -- default handler for installed servers
      function(server_name)
        lspconfig[server_name].setup {
          capabilities = capabilities,
          on_attach = on_attach,
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
            }
          }
        }
      end,
      ['omnisharp'] = function()
        lspconfig.omnisharp.setup {
          capabilities = capabilities,
          on_attach = on_attach,
          cmd = { "dotnet", "/home/mark/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll" },
        }
      end
    })
  end,
}
