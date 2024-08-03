if vim.g.vscode then return {} end
return {
  dir = '~/dev/plugins/csharp-namespace.nvim',
  ft = 'cs',
  event = 'InsertEnter',
  config = function() require('csharp-namespace').setup {} end,
}
