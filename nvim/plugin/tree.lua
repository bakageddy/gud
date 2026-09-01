vim.pack.add({
	{ src = "https://github.com/nvim-neo-tree/neo-tree.nvim", branch = "v3.x" },
	"https://github.com/MunifTanjim/nui.nvim",
})

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local neotree = require('neo-tree')
neotree.setup {
	icons = true,
	window = {
		width = 25,
		height = 15
	}
}

vim.api.nvim_create_autocmd(
	{ "VimEnter" },
	{
		callback = function(ev)
			if (vim.fn.isdirectory(ev.file) == 1) then
				vim.cmd [[Neotree]]
			end
		end
	}
)
