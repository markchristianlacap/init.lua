return {
  'ibhagwan/fzf-lua',
  -- optional for icon support
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local fzf = require 'fzf-lua'
    fzf.setup {}

    local opts = { noremap = true, silent = true, desc = '' }

    opts.desc = 'Find files'
    vim.keymap.set('n', '<leader>ff', fzf.files, opts)

    opts.desc = 'Find word'
    vim.keymap.set('n', '<leader>fw', fzf.live_grep, opts)

    opts.desc = 'Find buffer'
    vim.keymap.set('n', '<leader>fb', fzf.buffers, opts)

    opts.desc = 'Find Old files'
    vim.keymap.set('n', '<leader>fo', fzf.oldfiles, opts)

    opts.desc = 'Find help tags'
    vim.keymap.set('n', '<leader>fh', fzf.help_tags, opts)

    opts.desc = 'Find registers'
    vim.keymap.set('n', '<leader>fr', fzf.registers, opts)

    opts.desc = 'Find keymaps'
    vim.keymap.set('n', '<leader>fk', fzf.keymaps, opts)

    opts.desc = 'Find diagnostics'
    vim.keymap.set('n', '<leader>fd', fzf.diagnostics_document, opts)
  end,
}
