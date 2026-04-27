local dap = require("dap");
local mason_dap = require("mason-nvim-dap");

vim.keymap.set("n", "<leader>ds", dap.continue);
vim.keymap.set("n", "<leader>di", dap.step_into);
vim.keymap.set("n", "<leader>do", dap.step_out);
vim.keymap.set("n", "<leader>dv", dap.step_over);
vim.keymap.set("n", "<leader>br", dap.toggle_breakpoint);
-- vim.keymap.set("n", "<leader>du", dui.toggle);

mason_dap.setup {
	automatic_installation = false,
	handlers = {},
}

dap.adapters.codelldb = {
	type = "server",
	port = "5451",
	executable = {
		command = "/usr/bin/lldb",
		args = {
			"--port", "5451"
		},
	}
}

dap.configurations.rust = {
	{
		name = "Launch File",
		type = "codelldb",
		request = "launch",
		program = function ()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. '/', "file")
		end,
		stopOnEntry = false,

	}
}
