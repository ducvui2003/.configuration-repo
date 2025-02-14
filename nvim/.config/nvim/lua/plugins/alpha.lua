
return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- ASCII Header
    dashboard.section.header.val = {
      "  ____                    __  __                 ",
      " /\\  _`\\                 /\\ \\/\\ \\          __    ",
      " \\ \\ \\/\\ \\  __  __    ___\\ \\ \\ \\ \\  __  __/\\_\\   ",
      "  \\ \\ \\ \\ \\/\\ \\/\\ \\  /'___\\ \\ \\ \\ \\/\\ \\/\\ \\/\\ \\  ",
      "   \\ \\ \\_\\ \\ \\ \\_\\ \\/\\ \\__/\\ \\ \\_/ \\ \\ \\_\\ \\ \\ \\ ",
      "    \\ \\____/\\ \\____/\\ \\____\\\\ `\\___/\\ \\____/\\ \\_\\",
      "     \\/___/  \\/___/  \\/____/ `\\/__/  \\/___/  \\/_/ ",
      "                                                 ",
      "                                                 "
    }

    -- Dashboard Menu
    dashboard.section.buttons.val = {
      dashboard.button("e", "📄  New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("f", "🔍  Find file", ":Telescope find_files<CR>"),
      dashboard.button("r", "🕒  Recent files", ":Telescope oldfiles<CR>"),
      dashboard.button("p", "📁  Projects", ":Telescope projects<CR>"),
      dashboard.button("q", "🚪  Quit", ":qa<CR>"),
    }

    -- Footer
    dashboard.section.footer.val = {
      "🚀 Happy Coding with Neovim!",
      "🔗 github.com/ducvui2003"
    }

    -- Set up Alpha
    alpha.setup(dashboard.opts)
  end
}
