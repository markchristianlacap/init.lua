return {
  {
    dir = '~/dev/plugins/csharp-namespace.nvim',
    ft = 'cs',
    config = function() require('csharp-namespace').setup {} end,
  },
}
