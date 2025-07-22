-- if true then return {} end
if vim.g.vscode then return {} end
return {
  "seblyng/roslyn.nvim",
  ft = "cs",
  ---@module 'roslyn.config'
  ---@type RoslynNvimConfig
  opts = {},
}
