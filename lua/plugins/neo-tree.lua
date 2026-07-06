vim.pack.add({
	{
		src = gh("/nvim-neo-tree/neo-tree.nvim"),
		version = vim.version.range("3")
	},
	-- deps
	gh("/nvim-lua/plenary.nvim"),
	gh("/MunifTanjim/nui.nvim"),
	-- opt deps
	gh("/nvim-tree/nvim-web-devicons"),
})

require("neo-tree").setup({
	close_if_last_window = false,
	open_files_do_not_replace_types = { "terminal" },
	source_selector = {
		winbar = true,
		statusline = false
	}
})
vim.keymap.set("n", "<leader>nt", "<cmd>Neotree reveal toggle %:p:h:h<CR>", { desc = "Neotree - Open and reveal" })

