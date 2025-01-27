if vim.g.vscode then return {} end
return {
  "neovim/nvim-lspconfig",
    dependencies = { 'saghen/blink.cmp' },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lspconfig = require "lspconfig"
    local mason_lspconfig = require "mason-lspconfig"
 local capabilities = require('blink.cmp').get_lsp_capabilities()
    mason_lspconfig.setup_handlers { -- default handler for installed servers
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
    }
  end,
}
