vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'

--- format on save
local function format_on_save()
  local clients = vim.lsp.get_clients()
  for _, client in pairs(clients) do
    if client.name == 'excluded_lsp_server_name' then return end
  end
  vim.lsp.buf.format()
end
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function() format_on_save() end,
})
