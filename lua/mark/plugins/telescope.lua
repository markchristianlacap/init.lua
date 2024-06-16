return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local actions = require 'telescope.actions'
    local transform_mod = require('telescope.actions.mt').transform_mod

    local trouble = require 'trouble'
    local trouble_telescope = require 'trouble.sources.telescope'

    -- or create your custom action
    local custom_actions = transform_mod {
      open_trouble_qflist = function(prompt_bufnr) trouble.toggle 'quickfix' end,
    }
    require('telescope').setup {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      defaults = {
        path_display = { 'smart' },
        mappings = {
          i = {
            ['<C-k>'] = actions.move_selection_previous, -- move to prev result
            ['<C-j>'] = actions.move_selection_next, -- move to next result
            ['<C-q>'] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
            ['<C-t>'] = trouble_telescope.open,
          },
        },
      },
    }
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
    vim.keymap.set(
      'n',
      '<leader>fF',
      function() require('telescope.builtin').find_files { hidden = true, no_ignore = true } end,
      { desc = 'Find files (with hidden and no ignore)' }
    )

    vim.keymap.set('n', '<leader>fw', builtin.live_grep, { desc = 'Live grep (with hidden)' })
    vim.keymap.set('n', '<leader>fW', function()
      builtin.live_grep {
        additional_args = function(args) return vim.list_extend(args, { '--hidden', '--no-ignore' }) end,
      }
    end, { desc = 'Live grep (with hidden and no ignore)' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find existing buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find help tags' })
    vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = 'Find recently opened files' })
    vim.keymap.set('n', '<leader>fr', builtin.registers, { desc = 'Find registers' })
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Find keymaps' })
    vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Find diagnostics' })
  end,
}
