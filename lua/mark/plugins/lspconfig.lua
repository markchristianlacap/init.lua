if vim.g.vscode then return {} end
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
      ['volar'] = function()
        lspconfig.volar.setup {
          init_options = {
            vue = {
              hybridMode = false,
            },
          },
        }
      end,
      ['eslint'] = function()
        local customizations = {
          { rule = 'style/*',   severity = 'off', fixable = true },
          { rule = 'format/*',  severity = 'off', fixable = true },
          { rule = '*-indent',  severity = 'off', fixable = true },
          { rule = '*-spacing', severity = 'off', fixable = true },
          { rule = '*-spaces',  severity = 'off', fixable = true },
          { rule = '*-order',   severity = 'off', fixable = true },
          { rule = '*-dangle',  severity = 'off', fixable = true },
          { rule = '*-newline', severity = 'off', fixable = true },
          { rule = '*quotes',   severity = 'off', fixable = true },
          { rule = '*semi',     severity = 'off', fixable = true },
        }

        -- Enable eslint for all supported languages
        lspconfig.eslint.setup {
          filetypes = {
            'javascript',
            'javascriptreact',
            'javascript.jsx',
            'typescript',
            'typescriptreact',
            'typescript.tsx',
            'vue',
            'html',
            'markdown',
            'json',
            'jsonc',
            'yaml',
            'toml',
            'xml',
            'gql',
            'graphql',
            'astro',
            'svelte',
            'css',
            'less',
            'scss',
            'pcss',
            'postcss',
          },
          settings = {
            -- Silent the stylistic rules in you IDE, but still auto fix them
            rulesCustomizations = customizations,
          },
        }
      end,
    }
    require('roslyn').setup {
      capabilities = capabilities,
      exe = {
        'dotnet',
        vim.fs.joinpath(
          vim.fn.expand '~',
          '.vscode/extensions/ms-dotnettools.csharp-2.39.29-linux-x64/.roslyn/Microsoft.CodeAnalysis.LanguageServer.dll'
        ),
      },
    }
    -- manual lsp config
    require('lspconfig').unocss.setup {
      capabilities = capabilities,
    }
  end,
}
