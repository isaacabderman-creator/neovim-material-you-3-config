return {
  {
    name = "matugen-colorscheme",
    dir = vim.fn.stdpath("config"),
    lazy = false,
    priority = 1000,              
    config = function()
      vim.cmd("colorscheme matugen")
    end,
  },
}
