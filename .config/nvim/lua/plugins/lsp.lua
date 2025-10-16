local M = {}

local function setup_mason()
  local ok, mason = pcall(require, "mason")
  if not ok then return end

  mason.setup()
end

local function setup_mason_lsp(capabilities)
  local ok, mason_lspconfig = pcall(require, "mason-lspconfig")
  if not ok then return end

  mason_lspconfig.setup({
    ensure_installed = { "pyright", "lua_ls" },
    handlers = {
      function(server)
        local cfg = { capabilities = capabilities }

        if server == "pyright" then
          cfg.settings = {
            python = { venvPath = ".", venv = ".venv" },
          }
        elseif server == "lua_ls" then
          cfg.settings = {
            Lua = { diagnostics = { globals = { "vim" } } },
          }
        end

        vim.lsp.config[server] = cfg
        vim.lsp.enable(server)
      end,
    },
  })
end

local function setup_lspsaga()
  local ok, saga = pcall(require, "lspsaga")
  if ok then saga.setup({}) end
end

local function setup_keymaps()
  local opts = { desc = "LSP", silent = true }
  vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "LSP Hover" }))
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to Definition" }))
  vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "References" }))
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
end

function M.setup()
  setup_mason()

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  setup_mason_lsp(capabilities)
  setup_lspsaga()
  setup_keymaps()
end

return M

