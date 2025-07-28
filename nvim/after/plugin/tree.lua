local neotree = require('neo-tree')

neotree.setup {
	window = {
		width = 25,
		height = 15
	}
}

vim.api.nvim_create_autocmd(
	{ "VimEnter" }, 
	{ callback = function () vim.cmd [[Neotree]] end }
)
