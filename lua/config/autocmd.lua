local format_by_ft = {
  vue = { "eslint" },
  javascript = { "eslint" },
  typescript = { "eslint" },
  cs = { "roslyn", "null-ls" },
}

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    local ft = vim.bo.filetype
    if format_by_ft[ft] then
      for _, plugin in pairs(format_by_ft[ft]) do
        vim.lsp.buf.format { name = plugin }
      end
    else
      vim.lsp.buf.format()
    end
  end,
})

vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  group = 'YankHighlight',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 200 }
  end,
})
