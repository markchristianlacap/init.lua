return {
  dir = '~/dev/plugins/cs-to-ts.nvim',
  ft = 'cs',
  keys = {
    {
      '<leader>lc',
      mode = { 'v', 'n' },
      function()
        --get yanked text
        local text = vim.fn.getreg '"'
        -- convert
        local interface = require('cs-to-ts').convert(text)
        if interface then
          --put to vim register
          vim.fn.setreg('"', interface)
        end
      end,
      desc = 'Convert yanked C# to TypeScript interface',
    },
  },
}
