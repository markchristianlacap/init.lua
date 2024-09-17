if vim.g.vscode then return {} end
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup {
        flavour = "mocha",
        transparent_background = true,
        integrations = {
          mason = true,
        },
      }
      vim.cmd.colorscheme "catppuccin"
    end,
  },
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
      },
    },
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
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "catppuccin",
      },
    },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
  },
}
