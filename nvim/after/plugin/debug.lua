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

dap.configurations.java = {
	{
		type = 'java'
	}
}
