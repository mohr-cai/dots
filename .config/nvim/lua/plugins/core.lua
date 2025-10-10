return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        integrations = {
          cmp = true,
          gitsigns = true,
          lsp_trouble = true,
          mason = true,
          neotree = false,
          notify = true,
          telescope = true,
          treesitter = true,
          which_key = true,
        },
      })
    end,
  },
  { "nvim-lua/plenary.nvim" },
  { "nvim-tree/nvim-web-devicons", lazy = true },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          mappings = {
            i = {
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
            },
          },
        },
      })
      pcall(telescope.load_extension, "fzf")
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    cond = function()
      return vim.fn.executable("make") == 1
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "css",
          "dockerfile",
          "gitcommit",
          "go",
          "gomod",
          "html",
          "javascript",
          "json",
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "rust",
          "sql",
          "tsx",
          "typescript",
          "yaml",
        },
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
      })
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        disable_netrw = true,
        hijack_cursor = true,
        view = { width = 35 },
        renderer = {
          group_empty = true,
          highlight_git = true,
        },
        filters = { dotfiles = false },
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "catppuccin",
          globalstatus = true,
          section_separators = "",
          component_separators = { left = "", right = "" },
        },
      })
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      local toggleterm = require("toggleterm")
      toggleterm.setup({
        open_mapping = [[<c-\>]],
        direction = "float",
        float_opts = {
          border = "curved",
        },
      })

      local Terminal = require("toggleterm.terminal").Terminal
      local codex_term

      local function toggle_codex()
        if vim.fn.executable("codex") == 0 then
          vim.notify(
            "Codex CLI not found. Install with `brew install codex` or `npm install -g @openai/codex`.",
            vim.log.levels.WARN
          )
          return
        end

        if not codex_term then
          codex_term = Terminal:new({
            cmd = "codex",
            hidden = true,
            direction = "float",
            close_on_exit = false,
            float_opts = {
              border = "curved",
              width = math.floor(vim.o.columns * 0.8),
              height = math.floor(vim.o.lines * 0.8),
            },
            on_open = function(term)
              vim.api.nvim_buf_set_option(term.bufnr, "filetype", "codex")
              vim.cmd("startinsert")
            end,
          })
        end

        codex_term:toggle()
      end

      vim.api.nvim_create_user_command("Codex", toggle_codex, {
        desc = "Toggle Codex CLI in a floating terminal",
      })
    end,
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    config = function()
      require("nvim-surround").setup()
    end,
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({ check_ts = true })
    end,
  },
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup()
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup()
    end,
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup()
    end,
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      local notify = require("notify")
      notify.setup({ stages = "fade_in_slide_out" })
      vim.notify = notify
    end,
  },
}
