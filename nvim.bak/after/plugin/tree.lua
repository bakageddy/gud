local neotree = require('neo-tree')

neotree.setup {
	window = {
		width = 25,
		height = 15
	},
	dotfiles = true,
}

vim.api.nvim_create_autocmd(
	{ "VimEnter" }, 
	{ callback = function (ev)
		if (vim.fn.isdirectory(ev.file) == 1) then
			vim.cmd [[Neotree]]
		end
	end }
)
