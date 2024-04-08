---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        "███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓",
        "██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒",
        "▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░",
        "▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██ ",
        "▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒",
        "░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░",
        "░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░",
        "  ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░   ",
        "         ░    ░  ░    ░ ░        ░   ░         ░  ",
        "                               ░                  ",
      }
      return opts
    end,
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },
  {
    "navarasu/onedark.nvim",
    opts = function()
      require("onedark").setup { style = "deep" }
      require("onedark").load()
    end,
  },
  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
  { "NvChad/nvim-colorizer.lua", enabled = false },
  {
    "uga-rosa/ccc.nvim",
    event = { "User AstroFile", "InsertEnter" },
    cmd = { "CccPick", "CccConvert", "CccHighlighterEnable", "CccHighlighterDisable", "CccHighlighterToggle" },
    keys = {
      { "<leader>uC", "<cmd>CccHighlighterToggle<cr>", desc = "Toggle colorizer" },
      { "<leader>zc", "<cmd>CccConvert<cr>", desc = "Convert color" },
      { "<leader>zp", "<cmd>CccPick<cr>", desc = "Pick Color" },
    },
    opts = {
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
    },
    config = function(_, opts)
      require("ccc").setup(opts)
      if opts.highlighter and opts.highlighter.auto_enable then vim.cmd.CccHighlighterEnable() end
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "swift" })
      end
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "codelldb" })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "codelldb" })
    end,
  },
  {
    "AstroNvim/astrolsp",
    optional = true,
    ---@type AstroLSPOpts
    opts = {
      servers = { "sourcekit" },
    },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "stevearc/dressing.nvim",
    opts = {},
  },
  {
    "xbase-lab/xbase",
    ft = { "swift", "objcpp", "objc" },
    run = "make install",
    dependencies = {
      { "neovim/nvim-lspconfig", optional = true },
      { "nvim-telescope/telescope.nvim", optional = true },
      { "nvim-lua/plenary.nvim", optional = true },
      { "stevearc/dressing.nvim", optional = true }, -- (in case you don't use telescope but something else)
    },
    mappings = {
      --- Whether xbase mapping should be disabled.
      enable = true,
      --- Open build picker. showing targets and configuration.
      build_picker = "<leader>bp", --- set to 0 to disable
      --- Open run picker. showing targets, devices and configuration
      run_picker = "<leader>rp", --- set to 0 to disable
      --- Open watch picker. showing run or build, targets, devices and configuration
      watch_picker = "<leader>wp", --- set to 0 to disable
      --- A list of all the previous pickers
      all_picker = "<leader>ap", --- set to 0 to disable
      --- horizontal toggle log buffer
      toggle_split_log_buffer = "<leader>ls",
      --- vertical toggle log buffer
      toggle_vsplit_log_buffer = "<leader>lv",
    },
    statusline = {
      watching = { icon = "", color = "#1abc9c" },
      device_running = { icon = "", color = "#4a6edb" },
      success = { icon = "", color = "#1abc9c" },
      failure = { icon = "", color = "#db4b4b" },
    },
    --- Simulators to only include.
    --- run `xcrun simctl list` to get a full list of available simulator
    --- If the list is empty then all simulator available  will be included
    simctl = {
      iOS = {
        -- "iPhone 13 Pro", --- only use this devices
      },
      watchOS = {}, -- all available devices
      tvOS = {}, -- all available devices
    },
  },
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim", "stevearc/dressing.nvim" },
    opts = function() require("flutter-tools").setup {} end,
  },
  -- Add "flutter" extension to "telescope"
  { import = "astrocommunity.pack.yaml" },
  {
    "AstroNvim/astrolsp",
    optional = true,
    ---@type AstroLSPOpts
    opts = {
      ---@diagnostic disable: missing-fields
      handlers = { dartls = false },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "dart" })
      end
    end,
  },
  {
    "akinsho/flutter-tools.nvim",
    ft = "dart",
    opts = function(_, opts)
      local astrolsp_avail, astrolsp = pcall(require, "astrolsp")
      if astrolsp_avail then opts.lsp = astrolsp.lsp_opts "dartls" end
      opts.debugger = { enabled = true }
    end,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      {
        "jay-babu/mason-nvim-dap.nvim",
        optional = true,
        opts = function(_, opts)
          opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "dart" })
        end,
      },
      {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        optional = true,
        opts = function(_, opts)
          opts.ensure_installed =
            require("astrocore").list_insert_unique(opts.ensure_installed, { "dart-debug-adapter" })
        end,
      },
    },
  },
  -- Add "flutter" extension to "telescope"
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    opts = function() require("telescope").load_extension "flutter" end,
  },
  -- CSharp support
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "c_sharp" })
      end
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "csharpier" })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "csharp_ls" })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "coreclr" })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(
        opts.ensure_installed,
        { "csharp-language-server", "csharpier", "netcoredbg" }
      )
    end,
  },
  -- add support C++ cpp
  {
    "AstroNvim/astrolsp",
    optional = true,
    ---@type AstroLSPOpts
    opts = {
      ---@diagnostic disable: missing-fields
      config = {
        clangd = {
          capabilities = {
            offsetEncoding = "utf-8",
          },
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed =
          require("astrocore").list_insert_unique(opts.ensure_installed, { "cpp", "c", "objc", "cuda", "proto" })
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "clangd" })
    end,
  },
  {
    "p00f/clangd_extensions.nvim",
    lazy = true,
    dependencies = {
      "AstroNvim/astrocore",
      opts = {
        autocmds = {
          clangd_extensions = {
            {
              event = "LspAttach",
              desc = "Load clangd_extensions with clangd",
              callback = function(args)
                if assert(vim.lsp.get_client_by_id(args.data.client_id)).name == "clangd" then
                  require "clangd_extensions"
                  vim.api.nvim_del_augroup_by_name "clangd_extensions"
                end
              end,
            },
          },
        },
      },
    },
  },
  {
    "Civitasv/cmake-tools.nvim",
    ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    dependencies = {
      {
        "jay-babu/mason-nvim-dap.nvim",
        opts = function(_, opts)
          opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "codelldb" })
        end,
      },
    },
    opts = {},
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "clangd", "codelldb" })
    end,
  },
  -- add support CMAKE
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "cmake" })
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "neocmake" })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "neocmakelsp" })
    end,
  },
  --add telescope-coc-nvim
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "fannheyward/telescope-coc.nvim" },
    opts = function(_, opts)
      require("telescope").load_extension "coc"
      if not opts.extensions then opts.extensions = {} end
      opts.extensions.coc = {
        theme = "ivy",
        prefer_locations = true, -- always use Telescope locations to preview definitions/declarations/implementations etc
      }
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-telescope/telescope-live-grep-args.nvim" },
    opts = function() require("telescope").load_extension "live_grep_args" end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function()
      require("mason-tool-installer").setup {
        ensure_installed = {

          -- you can pin a tool to a particular version
          { "golangci-lint", version = "v1.47.0" },

          -- you can turn off/on auto_update per tool
          { "bash-language-server", auto_update = true },

          "lua-language-server",
          "vim-language-server",
          "gopls",
          "stylua",
          "shellcheck",
          "editorconfig-checker",
          "gofumpt",
          "golines",
          "gomodifytags",
          "gotests",
          "impl",
          "json-to-struct",
          "luacheck",
          "misspell",
          "revive",
          "shellcheck",
          "shfmt",
          "staticcheck",
          "vint",
        },

        -- affect :MasonToolsUpdate or :MasonToolsInstall.
        -- Default: false
        auto_update = true,

        -- Default: true
        run_on_start = true,

        -- Default: 0
        start_delay = 3000, -- 3 second delay

        -- Default: nil
        debounce_hours = 5, -- at least 5 hours between attempts to install/update
      }
    end,
  },
}
