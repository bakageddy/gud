local neotree = require('neo-tree')

neotree.setup {
	window = {
		width = 35,
		height = 15
	}
}

vim.api.nvim_create_autocmd(
	{ "VimEnter" }, 
	{ callback = function () vim.cmd [[Neotree]] end }
)
