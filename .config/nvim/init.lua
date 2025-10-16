-- bread's neovim config
-- keymaps are in lua/config/mappings.lua
-- install a patched font & ensure your terminal supports glyphs
-- enjoy :D

-- auto-detect .venv in current cwd
local function detect_python()
  local cwd = vim.loop.cwd()
  for _, suffix in ipairs({ "/.venv/bin/python", "/venv/bin/python" }) do
    local full = cwd .. suffix
    if vim.fn.executable(full) == 1 then return full end
  end
  local system_python = vim.fn.exepath("python3")
  return system_python ~= "" and system_python or "python3"
end

vim.g.python3_host_prog = detect_python()
vim.api.nvim_create_autocmd("DirChanged", {
  callback = function()
    vim.g.python3_host_prog = detect_python()
  end,
})

vim.g.start_time = vim.fn.reltime()
vim.loader.enable() --  SPEEEEEEEEEEED 

require("plugins").setup()

local function safe_require(module)
  local ok, result = pcall(require, module)
  if not ok then
    vim.schedule(function()
      vim.notify(("Failed to load %s: %s"):format(module, result), vim.log.levels.WARN)
    end)
  end
  return ok and result or nil
end

-- core config
safe_require("config.theme")
safe_require("config.options")
safe_require("config.autocmd")
safe_require("config.mappings")

-- plugin configs that should load immediately
for _, module in ipairs({
  "plugins.todo",
  "plugins.barbar",
  "plugins.colorizer",
  "plugins.colorscheme",
  "plugins.comment",
  "plugins.gitsigns",
  "plugins.lualine",
  "plugins.nvim-lint",
  "plugins.render-markdown",
}) do
  safe_require(module)
end

local deferred = safe_require("plugins.deferred")
if deferred and deferred.setup then deferred.setup() end

load_theme()

