
-- Customize Mason

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
        "java-language-server",
        "python-lsp-server",
        "kotlin_language_server",
        "clangd",
        "swiftlint",
        "ktlint",

        -- install formatters
        "stylua",
        "prettier",
        "csharpier",
        "autopep8",
        "luaformatter",

        -- install debuggers
        "debugpy",
        "python",
        "coreclr",
        "codelldb",
        "java-test",
        "java-debug-adapter",
        "kotlin-debug-adapter",

        -- install any other package
        "tree-sitter-cli",
      },
    },
  },
}
