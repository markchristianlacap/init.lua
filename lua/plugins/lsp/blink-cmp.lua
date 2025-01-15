---@module "lazy"
---@type LazySpec
return {
  {
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',
      'mikavilpas/blink-ripgrep.nvim',
      'markchristianlacap/csharp-namespace.nvim',
    },
    version = '*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'enter',
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },
      },
      completion = {
        list = { selection = { preselect = false, auto_insert = true } },
      },
      appearance = {
        nerd_font_variant = 'mono'
      },
      sources = {
        default = {
          'lsp',
          'path',
          'snippets',
          'buffer',
          'ripgrep',
          'csharp_namespace'
        },
        providers = {
          csharp_namespace = {
            module = "blink-csharp-namespace",
            name = "C# Namespace",
            opts = {}
          },
          ripgrep = {
            module = "blink-ripgrep",
            name = "Ripgrep",
            ---@module "blink-ripgrep"
            ---@type blink-ripgrep.Options
            opts = {
              prefix_min_len = 3,
              context_size = 5,
              max_filesize = "1M",
              project_root_marker = ".git",
              search_casing = "--ignore-case",
              additional_rg_options = {},
              fallback_to_regex_highlighting = true,
              debug = false,
            },
            transform_items = function(_, items)
              for _, item in ipairs(items) do
                item.labelDetails = {
                  description = "(rg)",
                }
              end
              return items
            end,
          },
        },
      },
    },
  }
}
