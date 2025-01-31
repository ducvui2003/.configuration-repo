return -- lazy.nvim
{
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    -- add any options here
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
    },
    config = function()
      local noice = require("noice")
      noice.setup({
        background_colour = "#000000",
      })

      vim.keymap.set("n", "<ESC>", function()
        noice.cmd("dismiss")
      end)

      vim.api.nvim_set_hl(0, "NotifyBackground", { bg = "#1e1e2e" })
      vim.notify = require("notify")
      vim.notify("Hello, Neovim!")
    end,
}