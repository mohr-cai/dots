return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = false,
        term_colors = true,
        dim_inactive = {
          enabled = true,
          shade = "dark",
          percentage = 0.25,
        },
        integrations = {
          cmp = true,
          gitsigns = true,
          illuminate = true,
          indent_blankline = {
            enabled = true,
            scope_color = "lavender",
            colored_indent_levels = false,
          },
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
          },
          noice = false,
          notify = true,
          nvimtree = true,
          telescope = {
            enabled = true,
          },
          treesitter = true,
          which_key = true,
        },
        custom_highlights = function(colors)
          return {
            NormalFloat = { bg = colors.mantle },
            FloatBorder = { fg = colors.lavender, bg = colors.mantle },
            WinSeparator = { fg = colors.surface1 },
            CursorLineNr = { fg = colors.peach },
            TelescopeSelection = { bg = colors.surface0, fg = colors.text },
            Pmenu = { bg = colors.mantle },
          }
        end,
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
          prompt_prefix = "   ",
          selection_caret = " ",
          selection_strategy = "reset",
          sorting_strategy = "ascending",
          layout_strategy = "horizontal",
          layout_config = {
            prompt_position = "top",
            horizontal = { preview_width = 0.6 },
          },
          borderchars = {
            prompt = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
            results = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
            preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
          },
          winblend = 10,
          path_display = { "truncate" },
          mappings = {
            i = {
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
              ["<C-Down>"] = "cycle_history_next",
              ["<C-Up>"] = "cycle_history_prev",
            },
          },
        },
      })
      pcall(telescope.load_extension, "fzf")
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = function()
      if vim.fn.executable("make") ~= 1 then
        return
      end
      local plugin_dir = vim.fn.stdpath("data") .. "/lazy/telescope-fzf-native.nvim"
      if vim.fn.isdirectory(plugin_dir) == 0 then
        return
      end
      local cmd = { "make", "-C", plugin_dir }
      if vim.system then
        local result = vim.system(cmd):wait()
        if result and result.code ~= 0 then
          local stderr = result.stderr
          if type(stderr) == "table" then
            stderr = table.concat(stderr, "\n")
          end
          vim.notify(
            ("telescope-fzf-native.nvim: make failed with exit code %d%s"):format(
              result.code,
              stderr and ("\n" .. stderr) or ""
            ),
            vim.log.levels.ERROR
          )
        end
      else
        local output = vim.fn.system(cmd)
        if vim.v.shell_error ~= 0 then
          vim.notify(
            ("telescope-fzf-native.nvim: make failed with exit code %d%s"):format(
              vim.v.shell_error,
              output ~= "" and ("\n" .. output) or ""
            ),
            vim.log.levels.ERROR
          )
        end
      end
    end,
    cond = function()
      return vim.fn.executable("make") == 1
    end,
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = function()
      local ok, themes = pcall(require, "telescope.themes")
      return {
        input = {
          default_prompt = "➜ ",
          win_options = {
            winblend = 10,
          },
        },
        select = {
          backend = { "telescope", "builtin" },
          telescope = ok and themes.get_dropdown({
            layout_config = { prompt_position = "top" },
            previewer = false,
          }) or nil,
          builtin = {
            winblend = 15,
            border = "rounded",
            relative = "cursor",
          },
        },
      }
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
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local bufferline = require("bufferline")
      local ok, catppuccin = pcall(require, "catppuccin.groups.integrations.bufferline")
      bufferline.setup({
        highlights = ok and catppuccin.get({ styles = { "italic" } }) or nil,
        options = {
          mode = "buffers",
          show_buffer_close_icons = false,
          show_close_icon = false,
          separator_style = "thin",
          always_show_bufferline = false,
          diagnostics = "nvim_lsp",
          diagnostics_indicator = function(count)
            return " (" .. count .. ")"
          end,
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              highlight = "Directory",
              separator = true,
            },
          },
        },
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local theme = require("lualine.themes.catppuccin")
      local function clear_mode_background(mode)
        local mode_theme = theme[mode]
        if not mode_theme then
          return
        end
        for _, section in pairs(mode_theme) do
          if type(section) == "table" then
            section.bg = nil
          end
        end
      end

      for _, mode in ipairs({ "normal", "insert", "visual", "command", "replace", "terminal", "inactive" }) do
        clear_mode_background(mode)
      end

      require("lualine").setup({
        options = {
          theme = theme,
          globalstatus = true,
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
          disabled_filetypes = { statusline = { "dashboard", "alpha" } },
        },
        sections = {
          lualine_a = { { "mode", icon = "" } },
          lualine_b = { { "branch", icon = "" }, "diff" },
          lualine_c = {
            {
              "filename",
              path = 1,
              symbols = {
                modified = " ",
                readonly = " ",
                unnamed = "No Name",
              },
            },
            { "diagnostics", sources = { "nvim_lsp" } },
          },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { { "progress", separator = " ", padding = { left = 1, right = 1 } } },
          lualine_z = { { "location", padding = { left = 1, right = 1 } } },
        },
        extensions = { "nvim-tree", "toggleterm", "quickfix" },
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
    "shortcuts/no-neck-pain.nvim",
    version = "*",
    config = function()
      local no_neck_pain = require("no-neck-pain")
      no_neck_pain.setup({
        width = 120,
      })

      local augroup = vim.api.nvim_create_augroup("NoNeckPainAutoEnable", { clear = true })
      vim.api.nvim_create_autocmd("VimEnter", {
        group = augroup,
        callback = function()
          vim.schedule(function()
            vim.cmd("NoNeckPain")
          end)
        end,
      })
    end,
  },
  {
    "folke/twilight.nvim",
    cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
    opts = {
      dimming = {
        alpha = 0.3,
        color = { "Normal", "#1e1e2e" },
      },
      context = 8,
      expand = {
        "function",
        "method",
        "table",
        "if_statement",
      },
    },
  },
  {
    "folke/zen-mode.nvim",
    dependencies = { "folke/twilight.nvim" },
    cmd = "ZenMode",
    config = function()
      local zen_mode = require("zen-mode")
      local last_status
      zen_mode.setup({
        window = {
          backdrop = 0.95,
          width = 0.6,
          height = 0.95,
          options = {
            number = false,
            relativenumber = false,
            signcolumn = "no",
            list = false,
          },
        },
        plugins = {
          gitsigns = { enabled = false },
          kitty = { enabled = false },
          options = {
            enabled = true,
            ruler = false,
            showcmd = false,
          },
          twilight = { enabled = true },
        },
        on_open = function()
          last_status = vim.opt.laststatus:get()
          vim.opt.laststatus = 0
          pcall(vim.cmd, "NoNeckPainDisable")
        end,
        on_close = function()
          if last_status then
            vim.opt.laststatus = last_status
          else
            vim.opt.laststatus = 3
          end
          pcall(vim.cmd, "NoNeckPainEnable")
        end,
      })
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
      local palette = require("catppuccin.palettes").get_palette("mocha")
      notify.setup({
        stages = "fade_in_slide_out",
        background_colour = palette.crust,
        timeout = 3000,
        render = "minimal",
        icons = {
          ERROR = "",
          WARN = "",
          INFO = "",
          DEBUG = "",
          TRACE = "✎",
        },
      })
      vim.notify = notify
    end,
  },
}
