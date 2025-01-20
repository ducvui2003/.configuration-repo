return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
     config = function()
    -- Set minimum and maximum width for Neo-tree
        local MIN_WIDTH = 20
        local MAX_WIDTH = 50

        -- Neo-tree setup
        require("neo-tree").setup({
          filesystem = {
            follow_current_file = true, -- Automatically expand to the current file's directory
            hijack_netrw_behavior = "open_current",
          },
          window = {
            width = MIN_WIDTH, -- Set the initial width
            mappings = {
              ["o"] = "open",
              ["<CR>"] = "open",
              ["<2-LeftMouse>"] = "open",
              ["<esc>"] = "close_window",
            },
          },
        })

        -- key map for neo tree
        vim.keymap.set("n", "<leader>v", ":Neotree filesystem reveal left<CR>", {})
        vim.keymap.set("n", "<leader>xx", ":Neotree filesystem close <CR>", {})

        vim.keymap.set("n", "<leader>w=", function()
          local new_width = vim.api.nvim_win_get_width(0) + 5
          if new_width <= MAX_WIDTH then
            vim.cmd("vertical resize " .. new_width)
          end
        end, { desc = "Increase Neo-tree width" })

        vim.keymap.set("n", "<leader>w-", function()
          local new_width = vim.api.nvim_win_get_width(0) - 5
          if new_width >= MIN_WIDTH then
            vim.cmd("vertical resize " .. new_width)
          end
        end, { desc = "Decrease Neo-tree width" })
    end,
}