local signs = require("gitsigns")
local neogit = require("neogit")

signs.setup {
	signs = {
		-- add = { text = '+' },
		-- change = { text = '~' },
		-- delete = { text = 'x'},
		-- topdelele = { text = '~' },
		-- changedelete = { text = '~' },
	}
}
neogit.setup {}

vim.keymap.set("n", "]c", "<CMD>Gitsigns next_hunk<CR>")
vim.keymap.set("n", "[c", "<CMD>Gitsigns prev_hunk<CR>")

vim.keymap.set("n", "<leader>ghb", signs.blame_line);
vim.keymap.set("n", "<leader>ghd", signs.diffthis);
vim.keymap.set("n", "<leader>ghD", function ()
	signs.diffthis '@'
end);
