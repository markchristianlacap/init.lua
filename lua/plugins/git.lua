if vim.g.vscode then return {} end
return {
  {
    "tpope/vim-fugitive",
  },
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    config = function() require("gitsigns").setup() end,
    keys = {
      { "<leader>gp", ":Gitsigns preview_hunk<CR>", desc = "Preview hunk" },
      { "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", desc = "Toggle current line blame" },
    },
  },
}
