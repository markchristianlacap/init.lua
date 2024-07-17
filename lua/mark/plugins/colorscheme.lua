return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      flavour = 'mocha',
      transparent_background = true,
    }
    vim.cmd.colorscheme 'catppuccin'
    -- set yank highlight
    vim.api.nvim_set_hl(0, 'YankHighlight', { link = 'IncSearch' })

    -- Automatically highlight yanked text using augroup lua and autocmd
    vim.api.nvim_create_autocmd('TextYankPost', {
      group = vim.api.nvim_create_augroup('YankHighlighting', {}),
      pattern = '*',
      callback = function() vim.highlight.on_yank() end,
    })
  end,
}
