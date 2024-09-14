local format_by_ft = {
  vue = { "null-ls" },
  javascript = { "null-ls" },
  typescript = { "null-ls" },
  cs = { "roslyn", "null-ls" }
}

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    local ft = vim.bo.filetype
    if format_by_ft[ft] then
      for _, plugin in pairs(format_by_ft[ft]) do
        vim.lsp.buf.format({ name = plugin })
      end
    else
      vim.lsp.buf.format()
    end
  end,
})
