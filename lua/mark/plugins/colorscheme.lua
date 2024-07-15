return {
  'rebelot/kanagawa.nvim',
  priority = 1000,
  opts = {},
  config = function()
    vim.cmd.colorscheme 'kanagawa'
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
