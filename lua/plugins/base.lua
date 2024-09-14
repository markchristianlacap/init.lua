if vim.g.vscode then return {} end
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
        integrations = {
          fidget = true,
          mason = true,
        },
      })
      vim.cmd.colorscheme "catppuccin"
    end
  },
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    lazy = false,
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    keys = {
      {
        "<leader>e",
        "<CMD>Oil<CR>",
        { desc = "Open Oil Explorer" },
      },
    },
  },
  {
    "max397574/better-escape.nvim",
    config = function() require("better_escape").setup() end,
  },
  {
    "j-hui/fidget.nvim",
    opts = {
      notification = {
        window = { winblend = 0 },
      }
    },
  }
}
