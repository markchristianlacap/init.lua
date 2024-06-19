vim.g.mapleader = ' '

vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Join lines' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Center search results' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Center search results' })

-- greatest remap ever
vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'Paste without losing original content' })

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Copy to clipboard' })
vim.keymap.set('n', '<leader>Y', [["+Y]], { desc = 'Copy to clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]], { desc = 'Delete without losing original content' })
vim.keymap.set('n', '<leader>lf', function() require('mark.utils').format() end, { desc = 'LSP Format code' })

vim.keymap.set(
  'n',
  '<leader>r',
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = 'Replace word under cursor' }
)

-- remap system default
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent' })
vim.keymap.set('v', '<', '<gv', { desc = 'Unindent' })

-- LSP
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(event)
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = event.buf, silent = true }
    -- set keybinds
    opts.desc = 'Show LSP references'
    vim.keymap.set('n', 'gR', '<cmd>Telescope lsp_references<CR>', opts) -- show definition, references

    opts.desc = 'Go to declaration'
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts) -- go to declaration

    opts.desc = 'Show LSP definitions'
    vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts) -- show lsp definitions

    opts.desc = 'Show LSP implementations'
    vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts) -- show lsp implementations

    opts.desc = 'Show LSP type definitions'
    vim.keymap.set('n', 'gt', '<cmd>Telescope lsp_type_definitions<CR>', opts) -- show lsp type definitions

    opts.desc = 'See available code actions'
    vim.keymap.set({ 'n', 'v' }, '<leader>la', vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

    opts.desc = 'Smart rename'
    vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, opts) -- smart rename

    opts.desc = 'Show buffer diagnostics'
    vim.keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts) -- show  diagnostics for file

    opts.desc = 'Show line diagnostics'
    vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts) -- show diagnostics for line

    opts.desc = 'Go to previous diagnostic'
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

    opts.desc = 'Go to next diagnostic'
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

    opts.desc = 'Show documentation for what is under cursor'
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

    opts.desc = 'Restart LSP'
    vim.keymap.set('n', '<leader>lR', ':LspRestart<CR>', opts) -- mapping to restart lsp if necessary
  end,
})
