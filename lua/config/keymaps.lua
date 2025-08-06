vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opts = { noremap = true, silent = true, desc = "" }
opts.desc = "Better escape"
vim.keymap.set("i", "jk", "<ESC>", opts)

opts.desc = "Move selection down"
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", opts)

opts.desc = "Move selection up"
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", opts)

opts.desc = "Join lines"
vim.keymap.set("n", "J", "mzJ`z", opts)
opts.desc = "Center search results"
vim.keymap.set("n", "n", "nzzzv", opts)
opts.desc = "Center search results"
vim.keymap.set("n", "N", "Nzzzv", opts)

-- greatest remap ever
opts.desc = "Paste without losing original content"
vim.keymap.set("x", "<leader>p", [["_dP]], opts)

-- next greatest remap ever : asbjornHaland
opts.desc = "Copy to clipboard"
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], opts)
opts.desc = "Copy to clipboard"
vim.keymap.set("n", "<leader>Y", [["+Y]], opts)
opts.desc = "Delete without losing original content"
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], opts)
opts.desc = "LSP Format code"
vim.keymap.set("n", "<leader>lf", function() require("mark.utils").format() end, opts)
opts.desc = "Replace word under cursor"
vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)

-- remap system default
opts.desc = "Scroll down"
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
opts.desc = "Scroll up"
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)
opts.desc = "Indent"
vim.keymap.set("v", ">", ">gv", opts)
opts.desc = "Unindent"
vim.keymap.set("v", "<", "<gv", opts)

--buffer remaps
opts.desc = "Close buffer"
vim.keymap.set("n", "<leader>c", ":bd<CR>", opts)
opts.desc = "Close all buffers"
vim.keymap.set("n", "<leader>bC", ":bufdo bd<CR>", opts)
opts.desc = "Close other buffers except current"
vim.keymap.set("n", "<leader>bc", ":%bd|e#<CR>", opts)

-- LSP
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(event)
    local lsp_opts = { buffer = event.buf, silent = true }

    -- set keybinds
    lsp_opts.desc = "Show LSP references"
    vim.keymap.set("n", "gR", vim.lsp.buf.references, lsp_opts) -- show definition, references

    lsp_opts.desc = "Go to declaration"
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, lsp_opts) -- go to declaration

    lsp_opts.desc = "Show LSP definitions"
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, lsp_opts) -- show lsp definitions

    lsp_opts.desc = "See available code actions"
    vim.keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, lsp_opts) -- see available code actions, in visual mode will apply to selection

    lsp_opts.desc = "Smart rename"
    vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, lsp_opts) -- smart rename

    lsp_opts.desc = "Show line diagnostics"
    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, lsp_opts) -- show diagnostics for line

    lsp_opts.desc = "Go to previous diagnostic"
    vim.keymap.set("n", "[d", function()
      vim.diagnostic.jump({ count = -1, float = true });
    end, lsp_opts) -- jump to previous diagnostic in buffer

    lsp_opts.desc = "Go to next diagnostic"
    vim.keymap.set("n", "]d", function()
      vim.diagnostic.jump({ count = 1, float = true });
    end, lsp_opts) -- jump to next diagnostic in buffer

    lsp_opts.desc = "Show documentation for what is under cursor"
    vim.keymap.set("n", "K", vim.lsp.buf.hover, lsp_opts) -- show documentation for what is under cursor

    lsp_opts.desc = "Restart LSP"
    vim.keymap.set("n", "<leader>lR", ":LspRestart<CR>", lsp_opts) -- mapping to restart lsp if necessary
  end,
})
