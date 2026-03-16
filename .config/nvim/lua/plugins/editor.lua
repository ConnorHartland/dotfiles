return {
  -- Ensure treesitter parsers for all configured languages
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash", "dockerfile", "go", "gomod", "gowork", "hcl",
        "helm", "html", "javascript", "json", "lua", "markdown",
        "markdown_inline", "python", "terraform", "tsx",
        "typescript", "vim", "yaml", "toml", "kdl",
      },
    },
  },

  -- Ensure formatters/linters via mason
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua", "shellcheck", "shfmt", "gofumpt", "ruff",
      },
    },
  },
}
