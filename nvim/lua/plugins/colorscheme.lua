return {
  -- Instala o One Dark Pro
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
    opts = {
      options = {
        transparency = true,
        cursorline = true,
      },
    },
  },

  -- Define o One Dark Pro como o tema padrão do LazyVim
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
    },
  },
}
