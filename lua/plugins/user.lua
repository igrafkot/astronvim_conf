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

  -- customize dashboard options
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = table.concat({
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
          }, "\n"),
        },
      },
    },
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
  --NOTE: Themes colorscheme onedark
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
   --NOTE: works from colors
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
     --NOTE: Xbase working from swift lang
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
  --NOTE: Blankline
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "User AstroFile",
    opts = {
      indent = {
        char = "│",
      },
      scope = {
        enabled = false,
      },
      exclude = {
        filetypes = { "help", "alpha", "dashboard", "Trouble", "lazy", "neo-tree" },
      },
      whitespace = {
        remove_blankline_trail = true,
      },
    },
  },
   --NOTE: Kotlin settings
   {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "kotlin" })
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed =
        require("astrocore").list_insert_unique(opts.ensure_installed, { "kotlin_language_server" })
    end,
  },

  {
    "jay-babu/mason-null-ls.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "ktlint" })
    end,
  },

  {
    "jay-babu/mason-nvim-dap.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "kotlin" })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(
        opts.ensure_installed,
        { "kotlin-language-server", "ktlint", "kotlin-debug-adapter" }
      )
    end,
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        kotlin = { "ktlint" },
      },
    },
  },
  --NOTE: cmake settings
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
  --NOTE: settongs C/C++
  {
    "AstroNvim/astrolsp",
    optional = true,
    opts = function(_, opts)
      opts.config = vim.tbl_deep_extend("keep", opts.config, {
        clangd = {
          capabilities = {
            offsetEncoding = "utf-8",
          },
        },
      })
      if is_linux_arm then opts.servers = require("astrocore").list_insert_unique(opts.servers, { "clangd" }) end
    end,
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
      if not is_linux_arm then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "clangd" })
      end
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
          clangd_extension_mappings = {
            {
              event = "LspAttach",
              desc = "Load clangd_extensions with clangd",
              callback = function(args)
                if assert(vim.lsp.get_client_by_id(args.data.client_id)).name == "clangd" then
                  require("astrocore").set_mappings({
                    n = {
                      ["<Leader>lw"] = { "<Cmd>ClangdSwitchSourceHeader<CR>", desc = "Switch source/header file" },
                    },
                  }, { buffer = args.buf })
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
      local tools = { "codelldb" }
      if not is_linux_arm then table.insert(tools, "clangd") end
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, tools)
    end,
  },
   --NOTE: CSharp support
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
    "Decodetalkers/csharpls-extended-lsp.nvim",
    dependencies = {
      {
        "AstroNvim/astrolsp",
        opts = {
          config = {
            csharp_ls = {
              handlers = {
                ["textDocument/definition"] = function(...) require("csharpls_extended").handler(...) end,
                ["textDocument/typeDefinition"] = function(...) require("csharpls_extended").handler(...) end,
              },
            },
          },
        },
      },
    },
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
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = { "Issafalcon/neotest-dotnet", config = function() end },
    opts = function(_, opts)
      if not opts.adapters then opts.adapters = {} end
      table.insert(opts.adapters, require "neotest-dotnet"(require("astrocore").plugin_opts "neotest-dotnet"))
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        cs = { "csharpier" },
      },
    },
  },
    --NOTE: dart support
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

      -- HACK: Disables the select treesitter textobjects because the Dart treesitter parser is very inefficient. Hopefully this gets fixed and this block can be removed in the future.
      -- Reference: https://github.com/AstroNvim/AstroNvim/issues/2707
      local select = vim.tbl_get(opts, "textobjects", "select")
      if select then select.disable = require("astrocore").list_insert_unique(select.disable, { "dart" }) end
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
    dependencies = { "nvim-lua/plenary.nvim" },
    specs = {
      -- Add "flutter" extension to "telescope"
      {
        "nvim-telescope/telescope.nvim",
        optional = true,
        opts = function() require("telescope").load_extension "flutter" end,
      },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "dart-debug-adapter" })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "dart" })
    end,
  },
   --NOTE: support JAVA
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "java" })
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "jdtls" })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "javadbg", "javatest" })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed =
        require("astrocore").list_insert_unique(opts.ensure_installed, { "jdtls", "java-debug-adapter", "java-test" })
    end,
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      {
        "AstroNvim/astrolsp",
        optional = true,
        ---@type AstroLSPOpts
        opts = {
          ---@diagnostic disable: missing-fields
          handlers = { jdtls = false },
        },
      },
    },
    opts = function(_, opts)
      local utils = require "astrocore"
      -- use this function notation to build some variables
      local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", ".project" }
      local root_dir = require("jdtls.setup").find_root(root_markers)
      -- calculate workspace dir
      local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
      local workspace_dir = vim.fn.stdpath "data" .. "/site/java/workspace-root/" .. project_name
      vim.fn.mkdir(workspace_dir, "p")

      -- validate operating system
      if not (vim.fn.has "mac" == 1 or vim.fn.has "unix" == 1 or vim.fn.has "win32" == 1) then
        utils.notify("jdtls: Could not detect valid OS", vim.log.levels.ERROR)
      end

      return utils.extend_tbl({
        cmd = {
          "java",
          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "-Dlog.protocol=true",
          "-Dlog.level=ALL",
          "-javaagent:" .. vim.fn.expand "$MASON/share/jdtls/lombok.jar",
          "-Xms1g",
          "--add-modules=ALL-SYSTEM",
          "--add-opens",
          "java.base/java.util=ALL-UNNAMED",
          "--add-opens",
          "java.base/java.lang=ALL-UNNAMED",
          "-jar",
          vim.fn.expand "$MASON/share/jdtls/plugins/org.eclipse.equinox.launcher.jar",
          "-configuration",
          vim.fn.expand "$MASON/share/jdtls/config",
          "-data",
          workspace_dir,
        },
        root_dir = root_dir,
        settings = {
          java = {
            eclipse = { downloadSources = true },
            configuration = { updateBuildConfiguration = "interactive" },
            maven = { downloadSources = true },
            implementationsCodeLens = { enabled = true },
            referencesCodeLens = { enabled = true },
            inlayHints = { parameterNames = { enabled = "all" } },
            signatureHelp = { enabled = true },
            completion = {
              favoriteStaticMembers = {
                "org.hamcrest.MatcherAssert.assertThat",
                "org.hamcrest.Matchers.*",
                "org.hamcrest.CoreMatchers.*",
                "org.junit.jupiter.api.Assertions.*",
                "java.util.Objects.requireNonNull",
                "java.util.Objects.requireNonNullElse",
                "org.mockito.Mockito.*",
              },
            },
            sources = {
              organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
              },
            },
          },
        },
        init_options = {
          bundles = {
            vim.fn.expand "$MASON/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar",
            -- unpack remaining bundles
            (table.unpack or unpack)(vim.split(vim.fn.glob "$MASON/share/java-test/*.jar", "\n", {})),
          },
        },
        handlers = {
          ["$/progress"] = function() end, -- disable progress updates.
        },
        filetypes = { "java" },
        on_attach = function(...)
          require("jdtls").setup_dap { hotcodereplace = "auto" }
          local astrolsp_avail, astrolsp = pcall(require, "astrolsp")
          if astrolsp_avail then astrolsp.on_attach(...) end
        end,
      }, opts)
    end,
    config = function(_, opts)
      -- setup autocmd on filetype detect java
      vim.api.nvim_create_autocmd("Filetype", {
        pattern = "java", -- autocmd to start jdtls
        callback = function()
          if opts.root_dir and opts.root_dir ~= "" then
            require("jdtls").start_or_attach(opts)
          else
            require("astrocore").notify("jdtls: root_dir not found. Please specify a root marker", vim.log.levels.ERROR)
          end
        end,
      })
      -- create autocmd to load main class configs on LspAttach.
      -- This ensures that the LSP is fully attached.
      -- See https://github.com/mfussenegger/nvim-jdtls#nvim-dap-configuration
      vim.api.nvim_create_autocmd("LspAttach", {
        pattern = "*.java",
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          -- ensure that only the jdtls client is activated
          if client.name == "jdtls" then require("jdtls.dap").setup_dap_main_class_configs() end
        end,
      })
    end,
  },
   --NOTE: support JSON
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    specs = {
      {
        "AstroNvim/astrolsp",
        optional = true,
        ---@type AstroLSPOpts
        opts = {
          ---@diagnostic disable: missing-fields
          config = {
            jsonls = {
              on_new_config = function(config)
                if not config.settings.json.schemas then config.settings.json.schemas = {} end
                vim.list_extend(config.settings.json.schemas, require("schemastore").json.schemas())
              end,
              settings = { json = { validate = { enable = true } } },
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
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "json", "jsonc" })
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "jsonls" })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "json-lsp" })
    end,
  },
   --NOTE: support proto
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      -- Ensure that opts.ensure_installed exists and is a table or string "all".
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "proto" })
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "buf_ls" })
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "buf" })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed =
        require("astrocore").list_insert_unique(opts.ensure_installed, { "buf-language-server", "buf" })
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        proto = { "buf" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        proto = { "buf_lint" },
      },
    },
  },
    --NOTE: support Python
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
    enabled = vim.fn.executable "fd" == 1 or vim.fn.executable "fdfind" == 1 or vim.fn.executable "fd-find" == 1,
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
    dependencies = { "nvim-neotest/neotest-python", config = function() end },
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
     --NOTE: XCode Build
    {
      "wojciech-kulik/xcodebuild.nvim",
      dependencies = {
        "nvim-telescope/telescope.nvim",
        "MunifTanjim/nui.nvim",
      },
      config = function()
        require("xcodebuild").setup({ 
          code_coverage = {
            enabled = true,
          },
        })
    
        vim.keymap.set("n", "<leader>xl", "<cmd>XcodebuildToggleLogs<cr>", { desc = "Toggle Xcodebuild Logs" })
        vim.keymap.set("n", "<leader>xb", "<cmd>XcodebuildBuild<cr>", { desc = "Build Project" })
        vim.keymap.set("n", "<leader>xr", "<cmd>XcodebuildBuildRun<cr>", { desc = "Build & Run Project" })
        vim.keymap.set("n", "<leader>xt", "<cmd>XcodebuildTest<cr>", { desc = "Run Tests" })
        vim.keymap.set("n", "<leader>xT", "<cmd>XcodebuildTestClass<cr>", { desc = "Run This Test Class" })
        vim.keymap.set("n", "<leader>X", "<cmd>XcodebuildPicker<cr>", { desc = "Show All Xcodebuild Actions" })
        vim.keymap.set("n", "<leader>xd", "<cmd>XcodebuildSelectDevice<cr>", { desc = "Select Device" })
        vim.keymap.set("n", "<leader>xp", "<cmd>XcodebuildSelectTestPlan<cr>", { desc = "Select Test Plan" })
        vim.keymap.set("n", "<leader>xc", "<cmd>XcodebuildToggleCodeCoverage<cr>", { desc = "Toggle Code Coverage" })
        vim.keymap.set("n", "<leader>xC", "<cmd>XcodebuildShowCodeCoverageReport<cr>", { desc = "Show Code Coverage Report" })
        vim.keymap.set("n", "<leader>xq", "<cmd>Telescope quickfix<cr>", { desc = "Show QuickFix List" })
      end,
    },
    --NOTE: UI-DAP
    {
      "rcarriga/nvim-dap-ui",
      dependencies = { "mfussenegger/nvim-dap", },
      lazy = true,
      config = function()
        require("dapui").setup({
          controls = {
            element = "repl",
            enabled = true,
          },
          floating = {
            border = "single",
            mappings = {
              close = { "q", "<Esc>" },
            },
          },
          icons = { collapsed = "", expanded = "", current_frame = "" },
          layouts = {
            {
              elements = {
                { id = "stacks", size = 0.25 },
                { id = "scopes", size = 0.25 },
                { id = "breakpoints", size = 0.25 },
                { id = "watches", size = 0.25 },
              },
              position = "left",
              size = 60,
            },
            {
              elements = {
                { id = "repl", size = 0.35 },
                { id = "console", size = 0.65 },
              },
              position = "bottom",
              size = 10,
            },
          },
        })
    
        local dap, dapui = require("dap"), require("dapui")
    
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close()
        end
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
   -- NOTE: == Auto save ==--
  -- {
  --   "Pocco81/auto-save.nvim",
  --   event = { "User AstroFile", "InsertEnter" },
  --   opts = {
  --     callbacks = {
  --       before_saving = function()
  --         -- save global autoformat status
  --         vim.g.OLD_AUTOFORMAT = vim.g.autoformat_enabled

  --         vim.g.autoformat_enabled = false
  --         vim.g.OLD_AUTOFORMAT_BUFFERS = {}
  --         -- disable all manually enabled buffers
  --         for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
  --           if vim.b[bufnr].autoformat_enabled then
  --             table.insert(vim.g.OLD_BUFFER_AUTOFORMATS, bufnr)
  --             vim.b[bufnr].autoformat_enabled = false
  --           end
  --         end
  --       end,
  --       after_saving = function()
  --         -- restore global autoformat status
  --         vim.g.autoformat_enabled = vim.g.OLD_AUTOFORMAT
  --         -- reenable all manually enabled buffers
  --         for _, bufnr in ipairs(vim.g.OLD_AUTOFORMAT_BUFFERS or {}) do
  --           vim.b[bufnr].autoformat_enabled = true
  --         end
  --       end,
  --     },
  --   },
  -- },
  -- {
  --   "okuuva/auto-save.nvim",
  --   event = { "User AstroFile", "InsertEnter" },
  --   dependencies = {
  --     "AstroNvim/astrocore",
  --     opts = {
  --       autocmds = {
  --         autoformat_toggle = {
  --           -- Disable autoformat before saving
  --           {
  --             event = "User",
  --             desc = "Disable autoformat before saving",
  --             pattern = "AutoSaveWritePre",
  --             callback = function()
  --               -- Save global autoformat status
  --               vim.g.OLD_AUTOFORMAT = vim.g.autoformat
  --               vim.g.autoformat = false

  --               local old_autoformat_buffers = {}
  --               -- Disable all manually enabled buffers
  --               for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
  --                 if vim.b[bufnr].autoformat then
  --                   table.insert(old_autoformat_buffers, bufnr)
  --                   vim.b[bufnr].autoformat = false
  --                 end
  --               end

  --               vim.g.OLD_AUTOFORMAT_BUFFERS = old_autoformat_buffers
  --             end,
  --           },
  --           -- Re-enable autoformat after saving
  --           {
  --             event = "User",
  --             desc = "Re-enable autoformat after saving",
  --             pattern = "AutoSaveWritePost",
  --             callback = function()
  --               -- Restore global autoformat status
  --               vim.g.autoformat = vim.g.OLD_AUTOFORMAT
  --               -- Re-enable all manually enabled buffers
  --               for _, bufnr in ipairs(vim.g.OLD_AUTOFORMAT_BUFFERS or {}) do
  --                 vim.b[bufnr].autoformat = true
  --               end
  --             end,
  --           },
  --         },
  --       },
  --     },
  --   },
  --   opts = {},
  -- },
    --NOTE: add telescope-coc-nvim
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
    --NOTE: Xbase working from swift lang
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
    --NOTE: works from colors
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
  
}
