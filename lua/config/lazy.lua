-- ==========================================
-- 🚀 Bootstrap lazy.nvim
-- ==========================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Use vim.uv for Neovim ≥ 0.10; fallback to vim.loop for older versions
local uv = vim.uv or vim.loop

if not uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  local ok, out = pcall(vim.fn.system, {
    "git", "clone", "--filter=blob:none", "--branch=stable", repo, lazypath,
  })

  if not ok or vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "❌ Failed to clone lazy.nvim\n", "ErrorMsg" },
      { out or "", "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

-- ==========================================
-- ⚙️ Setup lazy.nvim
-- ==========================================
require("lazy").setup({
  spec = {
    { import = "plugins" },
    { import = "plugins.lsp" },
  },
  defaults = {
    lazy = false,    -- load plugins immediately unless explicitly lazy
    version = false, -- always use latest git commit
  },
  checker = {
    enabled = true, -- auto-check for updates
    notify = false, -- disable noisy update notifications
  },
  change_detection = {
    enabled = true,
    notify = false, -- silent reload when plugin config changes
  },
  ui = {
    border = "rounded",
    icons = {
      cmd = " ",
      config = "🛠 ",
      event = "🗓 ",
      ft = "📄 ",
      init = "⚙ ",
      import = " ",
      keys = "🗝 ",
      lazy = "💤 ",
      loaded = "●",
      not_loaded = "○",
    },
  },
})
