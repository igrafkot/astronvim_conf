---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "User AstroFile",
    main = "lsp_signature",
    opts = {
      hint_enable = false, -- disable hints as it will crash in some terminal
    },
    specs = {
      {
        "folke/noice.nvim",
        optional = true,
        ---@type NoiceConfig
        opts = {
          lsp = {
            signature = { enabled = false },
            hover = { enabled = false },
          },
        },
      },
      { "AstroNvim/astrolsp", optional = true, opts = { features = { signature_help = false } } },
    },
  },

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  -- NOTE: Text ANSCII
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        " ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓",
        " ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒",
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
      require("onedark").setup {
        style = "dark",
        code_style = {
          comments = "italic",
          functions = "none",
          variables = "italic",
          keyboards = "none",
          strings = "italic",
        },
      }
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
  -- NOTE: Refactoring
  {
    "ThePrimeagen/refactoring.nvim",
    event = "User AstroFile",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      {
        "AstroNvim/astrocore",
        ---@param opts AstroCoreOpts
        opts = function(_, opts)
          local get_icon = require("astroui").get_icon
          return require("astrocore").extend_tbl(opts, {
            mappings = {
              n = {
                ["<Leader>r"] = { desc = get_icon("Refactoring", 1, true) .. "Refactor" },
                ["<Leader>rb"] = {
                  function() require("refactoring").refactor "Extract Block" end,
                  desc = "Extract Block",
                },
                ["<Leader>ri"] = {
                  function() require("refactoring").refactor "Inline Variable" end,
                  desc = "Inline Variable",
                },
                ["<Leader>rp"] = {
                  function() require("refactoring").debug.printf { below = false } end,
                  desc = "Debug: Print Function",
                },
                ["<Leader>rc"] = {
                  function() require("refactoring").debug.cleanup {} end,
                  desc = "Debug: Clean Up",
                },
                ["<Leader>rd"] = {
                  function() require("refactoring").debug.print_var { below = false } end,
                  desc = "Debug: Print Variable",
                },
                ["<Leader>rbf"] = {
                  function() require("refactoring").refactor "Extract Block To File" end,
                  desc = "Extract Block To File",
                },
              },
              x = {
                ["<Leader>r"] = { desc = get_icon("Refactoring", 1, true) .. "Refactor" },
                ["<Leader>re"] = {
                  function() require("refactoring").refactor "Extract Function" end,
                  desc = "Extract Function",
                },
                ["<Leader>rf"] = {
                  function() require("refactoring").refactor "Extract Function To File" end,
                  desc = "Extract Function To File",
                },
                ["<Leader>rv"] = {
                  function() require("refactoring").refactor "Extract Variable" end,
                  desc = "Extract Variable",
                },
                ["<Leader>ri"] = {
                  function() require("refactoring").refactor "Inline Variable" end,
                  desc = "Inline Variable",
                },
              },
              v = {
                ["<Leader>r"] = { desc = get_icon("Refactoring", 1, true) .. "Refactor" },
                ["<Leader>re"] = {
                  function() require("refactoring").refactor "Extract Function" end,
                  desc = "Extract Function",
                },
                ["<Leader>rf"] = {
                  function() require("refactoring").refactor "Extract Function To File" end,
                  desc = "Extract Function To File",
                },
                ["<Leader>rv"] = {
                  function() require("refactoring").refactor "Extract Variable" end,
                  desc = "Extract Variable",
                },
                ["<Leader>ri"] = {
                  function() require("refactoring").refactor "Inline Variable" end,
                  desc = "Inline Variable",
                },
                ["<Leader>rb"] = {
                  function() require("refactoring").refactor "Extract Block" end,
                  desc = "Extract Block",
                },
                ["<Leader>rbf"] = {
                  function() require("refactoring").refactor "Extract Block To File" end,
                  desc = "Extract Block To File",
                },
                ["<Leader>rr"] = {
                  function() require("refactoring").select_refactor() end,
                  desc = "Select Refactor",
                },
                ["<Leader>rp"] = {
                  function() require("refactoring").debug.printf { below = false } end,
                  desc = "Debug: Print Function",
                },
                ["<Leader>rc"] = {
                  function() require("refactoring").debug.cleanup {} end,
                  desc = "Debug: Clean Up",
                },
                ["<Leader>rd"] = {
                  function() require("refactoring").debug.print_var { below = false } end,
                  desc = "Debug: Print Variable",
                },
              },
            },
          } --[[@as AstroCoreOpts]])
        end,
      },
      {
        "AstroNvim/astroui",
        ---@type AstroUIOpts
        opts = {
          icons = {
            Refactoring = "󰣪",
          },
        },
      },
    },
    opts = {},
  },
  -- NOTE: swift settings
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
  -- works from colors
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
  -- Xbase working from swift lang
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
  -- Add "flutter" extension to "telescope"
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim", "stevearc/dressing.nvim" },
    opts = function() require("flutter-tools").setup {} end,
  },
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    opts = function() require("telescope").load_extension "flutter" end,
  },
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
  -- NOTE: Python language
  {
    {
      "AstroNvim/astrolsp",
      optional = true,
      ---@type AstroLSPOpts
      opts = {
        ---@diagnostic disable: missing-fields
        config = {
          basedpyright = {
            before_init = function(_, c)
              if not c.settings then c.settings = {} end
              if not c.settings.python then c.settings.python = {} end
              c.settings.python.pythonPath = vim.fn.exepath "python"
            end,
            settings = {
              basedpyright = {
                analysis = {
                  typeCheckingMode = "basic",
                  autoImportCompletions = true,
                  stubPath = vim.env.HOME .. "/typings",
                  diagnosticSeverityOverrides = {
                    reportUnusedImport = "information",
                    reportUnusedFunction = "information",
                    reportUnusedVariable = "information",
                    reportGeneralTypeIssues = "none",
                    reportOptionalMemberAccess = "none",
                    reportOptionalSubscript = "none",
                    reportPrivateImportUsage = "none",
                  },
                },
              },
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
          opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "python", "toml" })
        end
      end,
    },
    {
      "williamboman/mason-lspconfig.nvim",
      optional = true,
      opts = function(_, opts)
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "basedpyright" })
      end,
    },
    {
      "jay-babu/mason-null-ls.nvim",
      optional = true,
      opts = function(_, opts)
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "black", "isort" })
      end,
    },
    {
      "jay-babu/mason-nvim-dap.nvim",
      optional = true,
      opts = function(_, opts)
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "python" })
        if not opts.handlers then opts.handlers = {} end
        opts.handlers.python = function() end -- make sure python doesn't get set up by mason-nvim-dap, it's being set up by nvim-dap-python
      end,
    },
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      optional = true,
      opts = function(_, opts)
        opts.ensure_installed =
          require("astrocore").list_insert_unique(opts.ensure_installed, { "basedpyright", "black", "isort", "debugpy" })
      end,
    },
    {
      "linux-cultist/venv-selector.nvim",
      branch = "regexp",
      dependencies = {
        { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
        {
          "AstroNvim/astrocore",
          opts = {
            mappings = {
              n = {
                ["<Leader>lv"] = { "<Cmd>VenvSelect<CR>", desc = "Select VirtualEnv" },
              },
            },
          },
        },
      },
      opts = {},
      cmd = "VenvSelect",
    },
    {
      "mfussenegger/nvim-dap",
      optional = true,
      specs = {
        {
          "mfussenegger/nvim-dap-python",
          dependencies = "mfussenegger/nvim-dap",
          ft = "python", -- NOTE: ft: lazy-load on filetype
          config = function(_, opts)
            local path = vim.fn.exepath "python"
            local debugpy = require("mason-registry").get_package "debugpy"
            if debugpy:is_installed() then
              path = debugpy:get_install_path()
              if vim.fn.has "win32" == 1 then
                path = path .. "/venv/Scripts/python"
              else
                path = path .. "/venv/bin/python"
              end
            end
            require("dap-python").setup(path, opts)
          end,
        },
      },
    },
    {
      "nvim-neotest/neotest",
      optional = true,
      dependencies = { "nvim-neotest/neotest-python" },
      opts = function(_, opts)
        if not opts.adapters then opts.adapters = {} end
        table.insert(opts.adapters, require "neotest-python"(require("astrocore").plugin_opts "neotest-python"))
      end,
    },
    {
      "stevearc/conform.nvim",
      optional = true,
      opts = {
        formatters_by_ft = {
          python = { "isort", "black" },
        },
      },
    },
  },
  --NOTE: == JAVA ==
  {
  "nvim-java/nvim-java",
  lazy = true,
  opts = {},
  specs = {
    { "mfussenegger/nvim-jdtls", optional = true, enabled = false },
    {
      "AstroNvim/astrolsp",
      optional = true,
      ---@type AstroLSPOpts
      opts = {
        servers = { "jdtls" },
        handlers = {
          jdtls = function(server, opts)
            require("lazy").load { plugins = { "nvim-java" } }
            require("lspconfig")[server].setup(opts)
          end,
        },
      },
    },
  },
},
  -- NOTE: == Auto save ==--
  {
    "Pocco81/auto-save.nvim",
    event = { "User AstroFile", "InsertEnter" },
    opts = {
      callbacks = {
        before_saving = function()
          -- save global autoformat status
          vim.g.OLD_AUTOFORMAT = vim.g.autoformat_enabled

          vim.g.autoformat_enabled = false
          vim.g.OLD_AUTOFORMAT_BUFFERS = {}
          -- disable all manually enabled buffers
          for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
            if vim.b[bufnr].autoformat_enabled then
              table.insert(vim.g.OLD_BUFFER_AUTOFORMATS, bufnr)
              vim.b[bufnr].autoformat_enabled = false
            end
          end
        end,
        after_saving = function()
          -- restore global autoformat status
          vim.g.autoformat_enabled = vim.g.OLD_AUTOFORMAT
          -- reenable all manually enabled buffers
          for _, bufnr in ipairs(vim.g.OLD_AUTOFORMAT_BUFFERS or {}) do
            vim.b[bufnr].autoformat_enabled = true
          end
        end,
      },
    },
  },
  -- NOTE: Todo Comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    event = "User AstroFile",
    cmd = { "TodoTrouble", "TodoTelescope", "TodoLocList", "TodoQuickFix" },
  },
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    dependencies = {
      { "AstroNvim/astroui", opts = { icons = { Trouble = "󱍼" } } },
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          local prefix = "<Leader>x"
          maps.n[prefix] = { desc = require("astroui").get_icon("Trouble", 1, true) .. "Trouble" }
          maps.n[prefix .. "X"] =
            { "<Cmd>TroubleToggle workspace_diagnostics<CR>", desc = "Workspace Diagnostics (Trouble)" }
          maps.n[prefix .. "x"] =
            { "<Cmd>TroubleToggle document_diagnostics<CR>", desc = "Document Diagnostics (Trouble)" }
          maps.n[prefix .. "l"] = { "<Cmd>TroubleToggle loclist<CR>", desc = "Location List (Trouble)" }
          maps.n[prefix .. "q"] = { "<Cmd>TroubleToggle quickfix<CR>", desc = "Quickfix List (Trouble)" }
        end,
      },
    },
    opts = {
      use_diagnostic_signs = true,
      action_keys = {
        close = { "q", "<ESC>" },
        cancel = "<C-e>",
      },
    },
  },
  {
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      if not opts.bottom then opts.bottom = {} end
      table.insert(opts.bottom, "Trouble")
    end,
  },
  -- NOTE: support Toml
  {
    {
      "nvim-treesitter/nvim-treesitter",
      optional = true,
      opts = function(_, opts)
        -- Ensure that opts.ensure_installed exists and is a table or string "all".
        if opts.ensure_installed ~= "all" then
          opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "toml" })
        end
      end,
    },
    {
      "williamboman/mason-lspconfig.nvim",
      optional = true,
      opts = function(_, opts)
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "taplo" })
      end,
    },
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      optional = true,
      opts = function(_, opts)
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "taplo" })
      end,
    },
  },
}
