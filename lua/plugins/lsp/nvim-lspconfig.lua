if vim.g.vscode then return {} end
return {
  "neovim/nvim-lspconfig",
  dependencies = { "saghen/blink.cmp" },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lspconfig = require "lspconfig"
    local mason_lspconfig = require "mason-lspconfig"
    local capabilities = require('blink.cmp').get_lsp_capabilities()
    mason_lspconfig.setup { -- default handler for installed servers
      function(server_name)
        lspconfig[server_name].setup {
          capabilities = capabilities,
        }
      end,
      ["volar"] = function()
        lspconfig.volar.setup {
          capabilities = capabilities,
          settings = {
            vue = {
              complete = {
                casing = {
                  props = "kebab",
                  tags = "kebab",
                }
              }
            }
          },
          init_options = {
            typescript = {
              tsdk = vim.fn.expand(
                "~/.local/share/nvim/mason/packages/vue-language-server/node_modules/typescript/lib"
              ),
            },
          }
        }
      end,
      ["vtsls"] = function()
        lspconfig.vtsls.setup {
          capabilities = capabilities,
          filetypes = { "typescript", "javascript", "vue" },
          settings = {
            vtsls = {
              tsserver = {
                globalPlugins = {
                  {
                    name = "@vue/typescript-plugin",
                    location = require("mason-registry").get_package("vue-language-server"):get_install_path()
                        .. "/node_modules/@vue/language-server",
                    languages = { "vue" },
                    configNamespace = "typescript",
                    enableForWorkspaceTypeScriptVersions = true,
                  },
                },
              },
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
        lspconfig.eslint.setup(
          {
            filetypes = {
              "javascript",
              "javascriptreact",
              "javascript.jsx",
              "typescript",
              "typescriptreact",
              "typescript.tsx",
              "vue",
              "html",
              "markdown",
              "json",
              "jsonc",
              "yaml",
              "toml",
              "xml",
              "gql",
              "graphql",
              "astro",
              "svelte",
              "css",
              "less",
              "scss",
              "pcss",
              "postcss"
            },
            settings = {
              -- Silent the stylistic rules in you IDE, but still auto fix them
              rulesCustomizations = customizations,
            },
          }
        )
      end,
    }
    lspconfig.unocss.setup {
      capabilities = capabilities,
    }
  end,
}
