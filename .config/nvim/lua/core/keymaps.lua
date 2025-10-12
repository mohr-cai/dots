local map = vim.keymap.set
local opts = { silent = true }

-- General
map({ "n", "v" }, "<leader>q", "<cmd>q<cr>", vim.tbl_extend("force", opts, { desc = "Quit window" }))
map({ "n", "v" }, "<leader>w", "<cmd>w<cr>", vim.tbl_extend("force", opts, { desc = "Write buffer" }))
map("n", "<leader>h", "<cmd>nohlsearch<cr>", vim.tbl_extend("force", opts, { desc = "Clear highlights" }))
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", vim.tbl_extend("force", opts, { desc = "File explorer" }))
map("n", "<leader>t", "<cmd>ToggleTerm<cr>", vim.tbl_extend("force", opts, { desc = "Toggle terminal" }))
map("n", "<leader>uz", function()
  local ok, zen = pcall(require, "zen-mode")
  if ok then
    zen.toggle()
  else
    vim.notify("Zen mode plugin not available", vim.log.levels.WARN)
  end
end, vim.tbl_extend("force", opts, { desc = "Toggle zen mode" }))
map("n", "<leader>ut", "<cmd>Twilight<cr>", vim.tbl_extend("force", opts, { desc = "Toggle twilight" }))
map("n", "<leader>bp", "<cmd>BufferLinePick<cr>", vim.tbl_extend("force", opts, { desc = "Pick buffer" }))
map("n", "<leader>bd", "<cmd>BufferLinePickClose<cr>", vim.tbl_extend("force", opts, { desc = "Close buffer" }))

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", vim.tbl_extend("force", opts, { desc = "Find files" }))
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", vim.tbl_extend("force", opts, { desc = "Live grep" }))
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", vim.tbl_extend("force", opts, { desc = "Buffer list" }))
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", vim.tbl_extend("force", opts, { desc = "Help tags" }))

-- Git
map("n", "<leader>gs", "<cmd>Telescope git_status<cr>", vim.tbl_extend("force", opts, { desc = "Git status" }))
map("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", vim.tbl_extend("force", opts, { desc = "Git commits" }))

-- Codex CLI helper
map("n", "<leader>ai", function()
  vim.cmd("Codex")
end, vim.tbl_extend("force", opts, { desc = "Toggle Codex CLI" }))
