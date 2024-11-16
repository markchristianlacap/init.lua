if vim.g.vscode then return {} end
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local lspconfig = require "lspconfig"
    local mason_lspconfig = require "mason-lspconfig"
    local cmp_nvim_lsp = require "cmp_nvim_lsp"

    local capabilities = cmp_nvim_lsp.default_capabilities()
    mason_lspconfig.setup_handlers { -- default handler for installed servers
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
