local dap = require("dap");
local dui = require("dapui");
local mason_dap = require("mason-nvim-dap");

vim.keymap.set("n", "<leader>ds", dap.continue);
vim.keymap.set("n", "<leader>di", dap.step_into);
vim.keymap.set("n", "<leader>do", dap.step_out);
vim.keymap.set("n", "<leader>dv", dap.step_over);
vim.keymap.set("n", "<leader>br", dap.toggle_breakpoint);
vim.keymap.set("n", "<leader>du", dui.toggle);

mason_dap.setup {
	automatic_installation = true,
	handlers = {},
}

dui.setup {
	icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
	controls = {
		icons = {
			pause = '⏸',
			play = '▶',
			step_into = '⏎',
			step_over = '⏭',
			step_out = '⏮',
			step_back = 'b',
			run_last = '▶▶',
			terminate = '⏹',
			disconnect = '⏏',
		},
	},
}

dap.configurations.java = {
	{
		type = 'java';
	}
}

dap.listeners.after.event_initialized['dapui_config'] = dui.open
dap.listeners.before.event_terminated['dapui_config'] = dui.close
dap.listeners.before.event_exited['dapui_config'] = dui.close
