if vim.g.vscode then return {} end
return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- import mason
    local mason = require "mason"
    -- import mason-lspconfig
    local mason_lspconfig = require "mason-lspconfig"
    local mason_tool_installer = require "mason-tool-installer"

    -- import mason-tool-installer
    mason_tool_installer.setup {
      ensure_installed = {
        "stylua",
        "csharpier",
        "cspell",
        "eslint_d",
      },
    }
    -- enable mason and configure icons
    mason.setup {}

    mason_lspconfig.setup {
      -- list of servers for mason to install and auto setup
      ensure_installed = {
        "emmet_language_server",
        "volar",
        "unocss",
        "lua_ls",
        "cssls",
        "html",
        "vtsls",
        "jsonls",
        "rust_analyzer",
        "yamlls",
        "dockerls",
        "intelephense",
      },
    }
  end,
}
