-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

return { -- add gruvbox
-- Configure LazyVim to load gruvbox
{
    "LazyVim/LazyVim",
    opts = {
        colorscheme = "gruvbox"
    }
}}
