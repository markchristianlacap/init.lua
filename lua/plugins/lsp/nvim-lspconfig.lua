if vim.g.vscode then return {} end
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local vue_language_server_path = vim.fn.expand "$MASON/packages" ..
        "/vue-language-server" .. "/node_modules/@vue/language-server"
    local lspconfig = require("lspconfig")
    lspconfig.ts_ls.setup {
      init_options = {
        plugins = {
          {
            name = "@vue/typescript-plugin",
            location = vue_language_server_path,
            languages = { "vue" },
          },
        },
      },
      filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
    }
    lspconfig.volar.setup {
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
    }
  end
}
