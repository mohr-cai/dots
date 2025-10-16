local ok, todo = pcall(require, "todo-comments")
if not ok then return end

todo.setup({
  keywords = {
    TODO = { icon = "", color = "info" },
    FIX = { alt = { "FIXME", "BUG" } },
    HACK = {},
    NOTE = {},
  },
  search = {
    command = "rg",
    args = {
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
    },
  },
})

vim.keymap.set("n", "<leader>tn", todo.jump_next, { desc = "Next TODO" })
vim.keymap.set("n", "<leader>tp", todo.jump_prev, { desc = "Prev TODO" })
vim.keymap.set("n", "<leader>tt", "<cmd>TodoTelescope<cr>", { desc = "Search TODOs" })
vim.keymap.set("n", "<leader>tq", "<cmd>TodoQuickFix<cr>", { desc = "Quickfix TODOs" })
