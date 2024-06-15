return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup({
      integrations = {
        cmp = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = true,
        markdown = true,
        mason = true,
        native_lsp = { enabled = true },
        semantic_tokens = true,
        symbols_outline = true,
        telescope = true,
        treesitter = true,
      },
      -- transparent_background = true, -- disables setting the background color.
    })
    vim.cmd([[colorscheme catppuccin]])
  end
}
