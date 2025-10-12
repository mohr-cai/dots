-- Make sure this config root is in runtimepath
local cfg = "~/dots/.config/nvim"
vim.opt.rtp:prepend(cfg)

-- Also help Lua find modules in this config's lua/ dir
package.path = cfg .. "/lua/?.lua;" .. cfg .. "/lua/?/init.lua;" .. package.path

-- Bootstrap lazy.nvim if it is not already present.
require("core.bootstrap")

-- Core configuration.
require("core.options")
require("core.keymaps")
require("core.autocmds")

-- Plugin setup.
require("lazy").setup("plugins", {
  defaults = { lazy = false },
  install = { colorscheme = { "catppuccin", "habamax", "gruvbox"} },
  checker = { enabled = true, notify = false },
  change_detection = { notify = false },
  ui = { border = "rounded" },
})

-- Apply the colorscheme once plugins have loaded.
vim.schedule(function()
  local ok = pcall(vim.cmd.colorscheme, "gruvbox")
  if not ok then
    vim.notify("catppuccin theme not found, falling back to habamax", vim.log.levels.WARN)
    vim.cmd.colorscheme("habamax")
  end
end)
