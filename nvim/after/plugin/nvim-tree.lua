require("nvim-tree").setup({
	view = {
		width = "40%",
		side = "right",
		relativenumber = true,
		preserve_window_proportions = true,
	},
	renderer = {
		add_trailing = true,
		indent_markers = {
			enable = true,
		},
	},
})
