---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      -- Make sure to use the names found in `:Mason`
      ensure_installed = {
        -- install language servers
        "lua-language-server",
        "csharp_ls",
        "pyright",

        -- install formatters
        "stylua",
        "prettier",
        "csharpier",

        -- install debuggers
        "debugpy",
        "python",
        "coreclr",
        "codelldb",
        "javadbh",
        "javatest",
        "kotlin-debug-adapter",

        -- install any other package
        "tree-sitter-cli",
      },
    },
  },
}
