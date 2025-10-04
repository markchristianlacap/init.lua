-- ==========================================
-- 🧩 General Settings
-- ==========================================
local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.mouse = "a"               -- enable mouse support
opt.clipboard = "unnamedplus" -- use system clipboard
opt.swapfile = false          -- disable swap files
opt.undofile = true           -- persistent undo history
opt.backspace = "indent,eol,start"
opt.scrolloff = 8             -- keep cursor centered vertically
opt.sidescrolloff = 8         -- keep cursor centered horizontally

-- ==========================================
-- 📝 Tabs & Indentation
-- ==========================================
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.wrap = false

-- ==========================================
-- 🔍 Search
-- ==========================================
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true -- incremental search
opt.hlsearch = true  -- highlight search matches

-- ==========================================
-- 🎨 UI
-- ==========================================
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.cursorline = true
opt.splitright = true
opt.splitbelow = true
opt.showmode = false -- hide mode indicator since it's in statusline

-- ==========================================
-- 💡 Diagnostics & Icons
-- ==========================================
vim.g.have_nerd_font = true

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN]  = " ",
      [vim.diagnostic.severity.INFO]  = " ",
      [vim.diagnostic.severity.HINT]  = " ",
    },
  },
  virtual_text = { current_line = true },
  severity_sort = true,
  update_in_insert = false,
})
