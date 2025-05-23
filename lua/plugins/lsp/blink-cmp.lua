---@module "lazy"
---@type LazySpec
return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "markchristianlacap/csharp-namespace.nvim",
    },
    version = "*",
    ---@module "blink.cmp"
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "enter",
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
      },
      completion = {
        list = { selection = { preselect = false, auto_insert = true } },
      },
      appearance = {
        nerd_font_variant = "mono"
      },
      sources = {
        default = {
          "lazydev",
          "lsp",
          "path",
          "snippets",
          "buffer",
          "csharp_namespace"
        },
        providers = {
          csharp_namespace = {
            module = "blink-csharp-namespace",
            name = "C# Namespace",
            opts = {}
          },
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
      },
    },
  }
}
