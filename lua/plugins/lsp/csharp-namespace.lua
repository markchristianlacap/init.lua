return {
  {
    "markchristianlacap/csharp-namespace.nvim",
    ft = "cs",
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("csharp-namespace").setup {}
      local cmp = require "cmp"
      local config = cmp.get_config()
      table.insert(config.sources, {
        name = "csharp-namespace",
        group_index = 1,
        priority = 10000,
      })
      cmp.setup(config)
    end,
  },
}
