---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      -- add more arguments for adding more treesitter parsers
      "cpp",
      "c",
      "objc",
      "proto",
      "cmake",
      "swift",
      "c_sharp",
      "python",
      "java",
      "html",
      "kotlin",
      "css",
      "json",
      "jsonc",
      "rust",
      "toml",
      "sql",
    },
  },
}
