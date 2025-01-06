local dap = require("dap")

vim.keymap.set('n', '<F5>', require 'dap'.continue)
vim.keymap.set('n', '<F10>', require 'dap'.step_over)
vim.keymap.set('n', '<F11>', require 'dap'.step_into)
vim.keymap.set('n', '<F12>', require 'dap'.step_out)
vim.keymap.set('n', '<leader>b', require 'dap'.toggle_breakpoint)

dap.adapters.gdb = {
	type = "executable",
	command = "gdb",
	args = { "-i", "dap" }
}

dap.configurations.c = {
	{
		name = "file-merger",
		type = "gdb",
		request = "launch",
		program = "${workspaceFolder}/build/test/helper_test",
		cwd = '${workspaceFolder}'
	},
	{
		name = "data-structures",
		type = "gdb",
		request = "launch",
		program = "${workspaceFolder}/build/test/quicksort_test",
		cwd = '${workspaceFolder}'
	},
}
