return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies =  {
		"windwp/nvim-ts-autotag"
	},
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			-- auto install
			auto_install = true,
			-- add language you want to highlight in code
			ensure_installed = {
				"vim",
				"vimdoc",
				"lua",
				"javascript",
				"typescript",
				"tsx",
				"html",
                "css",
				"java",
				"json",
                "yaml",
                "python",
                "dockerfile",
			},
			sync_install = false,
			highlight = { enable = true },
			autotag = { enable = true },
			indent = { enable = true },
		})
	end,
}