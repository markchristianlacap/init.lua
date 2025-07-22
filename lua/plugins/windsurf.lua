if vim.g.vscode then return {} end
return {
  "Exafunction/windsurf.vim",
  config = function()
    vim.g.codeium_no_map_tab = 1
    -- Change '<C-g>' here to any keycode you like.
    vim.keymap.set("i", "<C-g>", function() return vim.fn["codeium#Accept"]() end, { expr = true, silent = true })
  end,
}
