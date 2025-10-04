vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Helper to add description
local function map(mode, lhs, rhs, desc)
  keymap(mode, lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
end

-- Normal & Insert basics
map("i", "jk", "<ESC>", "Better escape")
map("n", "<leader><leader>", "<cmd>nohlsearch<CR>", "Clear highlight")

-- Movement / Text editing
map("v", "<A-j>", ":m '>+1<CR>gv=gv", "Move selection down")
map("v", "<A-k>", ":m '<-2<CR>gv=gv", "Move selection up")
map("n", "<A-j>", ":m .+1<CR>==", "Move line down")
map("n", "<A-k>", ":m .-2<CR>==", "Move line up")
map("n", "J", "mzJ`z", "Join lines")
map("n", "n", "nzzzv", "Center search results")
map("n", "N", "Nzzzv", "Center search results")

-- Clipboard & delete operations
map("x", "<leader>p", [["_dP]], "Paste without losing original content")
map({ "n", "v" }, "<leader>y", [["+y]], "Copy to clipboard")
map("n", "<leader>Y", [["+Y]], "Copy line to clipboard")
map({ "n", "v" }, "<leader>d", [["_d]], "Delete without losing original content")
map("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Replace word under cursor")

-- Navigation & indentation
map("n", "<C-d>", "<C-d>zz", "Scroll down and center")
map("n", "<C-u>", "<C-u>zz", "Scroll up and center")
map("v", ">", ">gv", "Indent and stay in visual")
map("v", "<", "<gv", "Unindent and stay in visual")

-- Buffer management
map("n", "<leader>c", "<cmd>bd<CR>", "Close buffer")
map("n", "<leader>bC", "<cmd>bufdo bd<CR>", "Close all buffers")
map("n", "<leader>bc", "<cmd>%bd|e#<CR>", "Close other buffers")

-- Quickly open new splits
map("n", "<leader>sv", "<cmd>vsplit<CR>", "Vertical split")
map("n", "<leader>sh", "<cmd>split<CR>", "Horizontal split")

-- Keep cursor centered while jumping
map("n", "G", "Gzz", "End of file and center")
map("n", "gg", "ggzz", "Top of file and center")

-- Faster saving / quitting
map("n", "<leader>w", "<cmd>w<CR>", "Save file")
map("n", "<leader>q", "<cmd>q<CR>", "Quit window")
map("n", "<leader>wq", "<cmd>wq<CR>", "Save and quit")
-- ======================
-- 🔧 LSP CONFIGURATION
-- ======================
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(event)
    local bufopts = { buffer = event.buf, silent = true }

    local function lmap(mode, lhs, rhs, desc)
      keymap(mode, lhs, rhs, vim.tbl_extend("force", bufopts, { desc = desc }))
    end

    -- LSP mappings
    lmap("n", "gR", vim.lsp.buf.references, "Show LSP references")
    lmap("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
    lmap("n", "gd", vim.lsp.buf.definition, "Show LSP definitions")
    lmap({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, "Code actions")
    lmap("n", "<leader>lr", vim.lsp.buf.rename, "Smart rename")
    lmap("n", "<leader>ld", vim.diagnostic.open_float, "Show line diagnostics")

    lmap("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Prev diagnostic")
    lmap("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next diagnostic")

    lmap("n", "K", vim.lsp.buf.hover, "Hover documentation")
    lmap("n", "<leader>lR", "<cmd>LspRestart<CR>", "Restart LSP")
  end,
})
