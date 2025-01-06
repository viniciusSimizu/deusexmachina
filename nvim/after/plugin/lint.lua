require("lint").linters_by_ft = {
	lua = { "luacheck" },
	typescript = { "eslint" },
	javascript = { "eslint" },
	java = { "checkstyle" },
	c = { "cpplint" },
	cpp = { "cpplint" },
	html = { "tidy" },
	css = { "stylelint" },
	sql = { "sqlfluff" },
	yaml = { "yamllint" },
	markdown = { "markdownlint" },
	cmake = { "cmakelint" },
	dockerfile = { "hadolint" },
}

vim.api.nvim_create_autocmd("BufWritePost", {
	callback = function()
		require("lint").try_lint()
	end,
})
