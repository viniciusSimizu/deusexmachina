local dap, dapui = require("dap"), require("dapui")

vim.fn.sign_define('DapBreakpoint', { text='🔴', texthl='DapBreakpoint', linehl='', numhl='DapBreakpoint' })

dapui.setup()

dap.listeners.after.event_initialized["dapui_config"]=function()
	dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"]=function()
	dapui.close()
end

dap.listeners.before.event_exited["dapui_config"]=function()
	dapui.close()
end
