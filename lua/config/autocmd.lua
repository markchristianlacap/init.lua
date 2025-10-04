-- =======================================
-- 🧹 AUTO FORMATTING & LSP UTILITIES
-- =======================================

-- Filetype-based formatters
local format_by_ft = {
  vue = { "eslint" },
  javascript = { "eslint" },
  typescript = { "eslint" },
  cs = { "roslyn", "null-ls" },
}

-- Format before saving
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("AutoFormatOnSave", { clear = true }),
  callback = function()
    local ft = vim.bo.filetype
    local formatters = format_by_ft[ft]
    if formatters and #formatters > 0 then
      for _, name in ipairs(formatters) do
        pcall(vim.lsp.buf.format, { name = name })
      end
    else
      pcall(vim.lsp.buf.format)
    end
  end,
})

-- =======================================
-- ✨ YANK HIGHLIGHT
-- =======================================
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 200 }
  end,
})

-- =======================================
-- 🚀 LSP PROGRESS NOTIFICATIONS
-- =======================================
---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress = vim.defaulttable()

vim.api.nvim_create_autocmd("LspProgress", {
  ---@param ev { data: { client_id: integer, params: lsp.ProgressParams } }
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then return end

    local value = ev.data.params.value
    if type(value) ~= "table" then return end

    local client_progress = progress[client.id]
    local token = ev.data.params.token
    local percentage = value.kind == "end" and 100 or (value.percentage or 100)
    local title = value.title or ""
    local message = value.message and (" **%s**"):format(value.message) or ""

    local msg = ("[%3d%%] %s%s"):format(percentage, title, message)
    local updated = false

    for i, entry in ipairs(client_progress) do
      if entry.token == token then
        client_progress[i] = { token = token, msg = msg, done = value.kind == "end" }
        updated = true
        break
      end
    end

    if not updated then
      table.insert(client_progress, { token = token, msg = msg, done = value.kind == "end" })
    end

    -- Filter out finished progress items
    local display_msgs = {}
    progress[client.id] = vim.tbl_filter(function(v)
      table.insert(display_msgs, v.msg)
      return not v.done
    end, client_progress)

    -- Spinner animation
    local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    local icon = #progress[client.id] == 0
        and " "
        or spinner[(math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner) + 1]

    vim.notify(table.concat(display_msgs, "\n"), vim.log.levels.INFO, {
      id = "lsp_progress",
      title = client.name,
      icon = icon,
    })
  end,
})

-- =======================================
-- 🗂️ MINI FILES INTEGRATION (Snacks)
-- =======================================
vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesActionRename",
  callback = function(ev)
    if Snacks and Snacks.rename then
      Snacks.rename.on_rename_file(ev.data.from, ev.data.to)
    end
  end,
})
