vim.pack.add({
    gh("/nvim-telescope/telescope.nvim"),
	-- deps
	gh("/nvim-lua/plenary.nvim"),
	{
		src = gh("/nvim-telescope/telescope-fzf-native.nvim"),
		build = "make"
	}
})

-- vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope - Find files" })
-- vim.keymap.set("n", "<leader>fgrep", builtin.live_grep, { desc = "Telescope - Live grep" })
-- vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope - Help tags" })

