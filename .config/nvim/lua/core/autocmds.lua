local autocmd = vim.api.nvim_create_autocmd

-- Highlight visual selection after yanking.
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

-- Remove trailing whitespace on write.
autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local view = vim.fn.winsaveview()
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.winrestview(view)
  end,
})

local function apply_transparency()
  local groups = {
    "Normal",
    "NormalNC",
    "NormalFloat",
    "FloatBorder",
    "NeoTreeNormal",
    "NeoTreeNormalNC",
    "SignColumn",
    "EndOfBuffer",
  }
  for _, group in ipairs(groups) do
    vim.api.nvim_set_hl(0, group, { bg = "none" })
  end
end

autocmd({ "ColorScheme", "VimEnter" }, {
  callback = function()
    apply_transparency()
  end,
})
