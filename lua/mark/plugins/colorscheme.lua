local flavour = 'mocha'
return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      flavour = flavour,              -- latte, frappe, macchiato, mocha
      transparent_background = false, -- disables setting the background color.
      integrations = {
        mason = true,
        harpoon = true,
        lsp_trouble = true,
      },
    }

    local palette = require('catppuccin.palettes').get_palette(flavour)

    -- set hightlight group for yanked text
    vim.api.nvim_set_hl(0, 'YankHighlight', {
      bg = palette.yellow,
      fg = palette.mauve,
      blend = 100,
    })

    -- Automatically highlight yanked text using augroup lua and autocmd
    vim.api.nvim_create_autocmd('TextYankPost', {
      group = vim.api.nvim_create_augroup('YankHighlighting', {}),
      pattern = '*',
      callback = function() vim.highlight.on_yank { higroup = 'YankHighlight', timeout = 200 } end,
    })

    vim.cmd [[colorscheme catppuccin]]
  end,
}
