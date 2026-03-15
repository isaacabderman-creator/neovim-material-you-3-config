return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim", -- bridges mason ↔ lsp
      "hrsh7th/cmp-nvim-lsp",
      {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = {
          ensure_installed = { "stylua", "black", "prettier" },
        },
      }
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright" }, -- auto-installs these
      })
      require("mason").setup()
      vim.api.nvim_create_autocmd("User", {
        pattern = "MasonToolsStartingInstall",
        callback = function()
          vim.schedule(function() print("mason-tool-installer is starting") end)
        end,
      })
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.config("pyright", {
        cmd = { "pyright-langserver", "--stdio" },
        root_markers = { ".git", "pyproject.toml" },
        capabilities = capabilities,
      })

      vim.lsp.config("lua_ls", {
        cmd = { "lua-language-server" },
        root_markers = { ".git", "lua" },
        capabilities = capabilities,
      })

      vim.lsp.enable({ "lua_ls", "pyright" })
    end,
  },
}
