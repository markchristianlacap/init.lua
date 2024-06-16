local M = {
  format = function()
    local clients = vim.lsp.get_clients()
    local eslint_installed = vim.fn.exists ':EslintFixAll' ~= 0
    if not eslint_installed then goto next end
    for _, client in pairs(clients) do
      if client.name == 'volar' then
        vim.cmd('EslintFixAll')
        return
      end
    end
    ::next::
    -- fallback format
    vim.lsp.buf.format()
  end
}

return M
