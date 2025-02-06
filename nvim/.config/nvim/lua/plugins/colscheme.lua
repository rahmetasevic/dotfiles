return {
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    -- priority = 1000,
    opts = {
      transparent_background = true,
    },
    -- config = function()
    -- vim.cmd.colorscheme "catppuccin"
    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none", fg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})
    -- vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none", fg = "none", })
    -- vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "none", fg = "none"})
    -- vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "none", fg = "none"})
    -- end,
  },
  {
    "rose-pine/neovim",
    lazy = false,
    name = "rose-pine",
    priority = 1000,
    opts = {
      styles = {
        transparency = true,
      },
    },
    config = function()
      vim.cmd.colorscheme("rose-pine")
      vim.api.nvim_set_hl(0, "Normal", { bg = "none", fg = "none" })
      vim.api.nvim_set_hl(0, "NormalNC", { bg = "none", fg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
      vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "none", fg = "none" })
      vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "none", fg = "none" })
      vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none" })
      vim.api.nvim_set_hl(0, "TelescopeTitle", { bg = "none" })

      -- Decorate floating windows
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
      vim.lsp.handlers["textDocument/signatureHelp"] =
          vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

      vim.diagnostic.config({
        virtual_text = {
          source = "if_many",
          prefix = " ●",
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "if_many",
          header = "",
          prefix = "",
        },
      })
    end,
  },
}
