return {
  dir = '~/dev/plugins/cs-to-ts.nvim',
  ft = 'cs',
  keys = {
    -- on visual mode run cs-to-ts
    {
      '<leader>lc',
      mode = 'v',
      function()
        local utils = require 'cs-to-ts.utils'
        local text = utils.get_visual_selection()
        -- convert
        local interface = require('cs-to-ts').convert(text)
        if interface then
          --put to vim register
          vim.fn.setreg('+', interface)
        end
      end,
      desc = 'cs-to-ts'
    },
  }
}
