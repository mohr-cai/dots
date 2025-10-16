local M = {}

local function safe_require(module)
  local ok, result = pcall(require, module)
  if not ok then
    vim.schedule(function()
      vim.notify(("Failed to load %s: %s"):format(module, result), vim.log.levels.WARN)
    end)
    return nil
  end
  return result
end

local deferred_modules = {
  "plugins.autopairs",
  "plugins.fterm",
  "plugins.fzf-lua",
  "plugins.nvim-tree",
  "plugins.treesitter",
  "plugins.twilight",
  "plugins.which-key",
}

function M.setup()
  vim.defer_fn(function()
    for _, module in ipairs(deferred_modules) do
      safe_require(module)
    end
    local lsp = safe_require("plugins.lsp")
    if type(lsp) == "table" and lsp.setup then lsp.setup() end
  end, 100)
end

return M
