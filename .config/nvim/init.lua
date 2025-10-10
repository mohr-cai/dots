-- Bootstrap lazy.nvim if it is not already present.
require("core.bootstrap")

-- Core configuration.
require("core.options")
require("core.keymaps")
require("core.autocmds")

-- Plugin setup.
require("lazy").setup("plugins", {
  defaults = { lazy = false },
  install = { colorscheme = { "catppuccin", "tokyonight", "gruvbox" } },
  checker = { enabled = true, notify = false },
  change_detection = { notify = false },
  ui = { border = "rounded" },
})

-- Apply the colorscheme once plugins have loaded.
vim.schedule(function()
  local ok = pcall(vim.cmd.colorscheme, "catppuccin")
  if not ok then
    vim.notify("catppuccin theme not found, falling back to habamax", vim.log.levels.WARN)
    vim.cmd.colorscheme("habamax")
  end
end)
