if vim.g.vscode then return {} end
return {
  "windwp/nvim-ts-autotag",
  event = "InsertEnter",
  config = function() require("nvim-ts-autotag").setup() end,
}
