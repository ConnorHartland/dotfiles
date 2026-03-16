return {
  -- Customize claudecode.nvim (already loaded via lazyvim extra)
  {
    "coder/claudecode.nvim",
    opts = {
      visual_demotion = true,
    },
  },

  -- avante.nvim — AI chat panel + code suggestions using Claude API
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    build = "make",
    opts = {
      provider = "claude",
      providers = {
        claude = {
          model = "claude-sonnet-4-20250514",
        },
      },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "MeanderingProgrammer/render-markdown.nvim",
    },
  },

  -- Better markdown rendering (used by avante and general markdown editing)
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "Avante" },
    opts = {},
  },
}
