return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    { 'antosha417/nvim-lsp-file-operations', config = true },
    'seblj/roslyn.nvim',
  },
  config = function()
    local lspconfig = require 'lspconfig'
    local mason_lspconfig = require 'mason-lspconfig'
    local cmp_nvim_lsp = require 'cmp_nvim_lsp'

    local capabilities = cmp_nvim_lsp.default_capabilities()
    mason_lspconfig.setup_handlers { -- default handler for installed servers
      function(server_name)
        lspconfig[server_name].setup {
          capabilities = capabilities,
        }
      end,
      ['tsserver'] = function()
        local mason_registry = require 'mason-registry'
        local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path()
            .. '/node_modules/@vue/language-server'
        lspconfig.tsserver.setup {
          init_options = {
            plugins = {
              {
                name = '@vue/typescript-plugin',
                location = vue_language_server_path,
                languages = { 'vue' },
              },
            },
          },
          filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
        }
      end,
      -- ['vtsls'] = function()
      --   lspconfig.vtsls.setup {
      --     capabilities = capabilities,
      --     filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
      --     settings = {
      --       vtsls = {
      --         tsserver = {
      --           globalPlugins = {
      --             {
      --               name = '@vue/typescript-plugin',
      --               location = require('mason-registry').get_package('vue-language-server'):get_install_path()
      --                   .. '/node_modules/@vue/language-server',
      --               languages = { 'vue' },
      --               configNamespace = 'typescript',
      --               enableForWorkspaceTypeScriptVersions = true,
      --             },
      --           },
      --         },
      --       },
      --     },
      --   }
      -- end,
    }
    require('roslyn').setup {
      capabilities = capabilities,
      exe = vim.fs.joinpath(
        vim.fn.expand '~',
        '.vscode/extensions/ms-dotnettools.csharp-2.34.12-linux-x64/.roslyn/Microsoft.CodeAnalysis.LanguageServer.dll'
      ),
    }
    -- manual lsp config
    require('lspconfig').unocss.setup {
      capabilities = capabilities,
    }
  end,
}
