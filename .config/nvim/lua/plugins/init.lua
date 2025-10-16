local M = {}

local function bootstrap_vimplug()
  local data_dir = vim.fn.stdpath("data")
  local plug_path = data_dir .. "/site/autoload/plug.vim"

  if vim.fn.empty(vim.fn.glob(plug_path)) == 1 then
    vim.cmd(
      "silent !curl -fLo "
        .. plug_path
        .. " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    )
    vim.cmd("autocmd VimEnter * PlugInstall --sync | source $MYVIMRC")
  end
end

function M.setup()
  bootstrap_vimplug()

  local Plug = vim.fn["plug#"]

  vim.call("plug#begin")

  Plug("nvim-lua/plenary.nvim")
  Plug("nvim-telescope/telescope.nvim")
  Plug("neovim/nvim-lspconfig")
  Plug("williamboman/mason.nvim")
  Plug("williamboman/mason-lspconfig.nvim")
  Plug("nvimdev/lspsaga.nvim")
  Plug("github/copilot.vim")
  Plug("catppuccin/nvim", { ["as"] = "catppuccin" })
  Plug("ellisonleao/gruvbox.nvim", { ["as"] = "gruvbox" })
  Plug("uZer/pywal16.nvim", { ["as"] = "pywal16" })
  Plug("nvim-lualine/lualine.nvim")
  Plug("nvim-tree/nvim-web-devicons")
  Plug("folke/which-key.nvim")
  Plug("romgrk/barbar.nvim")
  Plug("goolord/alpha-nvim")
  Plug("nvim-treesitter/nvim-treesitter")
  Plug("mfussenegger/nvim-lint")
  Plug("nvim-tree/nvim-tree.lua")
  Plug("windwp/nvim-autopairs")
  Plug("lewis6991/gitsigns.nvim")
  Plug("numToStr/Comment.nvim")
  Plug("folke/todo-comments.nvim")
  Plug("norcalli/nvim-colorizer.lua")
  Plug("ibhagwan/fzf-lua")
  Plug("numToStr/FTerm.nvim")
  Plug("ron-rs/ron.vim")
  Plug("MeanderingProgrammer/render-markdown.nvim")
  Plug("emmanueltouzery/decisive.nvim")
  Plug("folke/twilight.nvim")

  vim.call("plug#end")
end

return M

