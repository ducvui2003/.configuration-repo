vim.keymap.set("n", "<leader>h", function()
	local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(",") - 1 })
    if #diagnostics then
       local message = diagnostics[1].message
        vim.fn.setreg("+", message)
        print("Copy diagnostic: " .. message)
    else
        print("No diagnostic")
    end
end, {noremap = true , silent = true, desc="Copy error to clipboard"})

vim.keymap.set("n", "<leader>ne", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>pe", vim.diagnostic.goto_prev)
