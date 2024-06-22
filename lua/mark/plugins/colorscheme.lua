local flavour = 'mocha'
return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      flavour = flavour, -- latte, frappe, macchiato, mocha
      background = {     -- :h background
        light = 'latte',
        dark = flavour,
      },
      transparent_background = false, -- disables setting the background color.
      show_end_of_buffer = true,      -- shows the '~' characters after the end of buffers
      term_colors = true,             -- sets terminal colors (e.g. `g:terminal_color_0`)
      dim_inactive = {
        enabled = false,              -- dims the background color of inactive window
        shade = 'dark',
        percentage = 0.15,            -- percentage of the shade to apply to the inactive window
      },
      no_italic = false,              -- Force no italic
      no_bold = false,                -- Force no bold
      no_underline = false,           -- Force no underline
      styles = {                      -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { 'italic' },      -- Change the style of comments
        conditionals = { 'italic' },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
        -- miscs = {}, -- Uncomment to turn off hard-coded styles
      },
      color_overrides = {},
      custom_highlights = {},
      default_integrations = true,
      integrations = {
        cmp = true,
        gitsigns = true,
        treesitter = true,
        mini = {
          enabled = true,
          indentscope_color = '',
        },
        flash = true,
        harpoon = true,
        mason = true,
        native_lsp = true,
        telescope = true,
        window_picker = true,
        semantic_tokens = true,
        symbols_outline = true,
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
