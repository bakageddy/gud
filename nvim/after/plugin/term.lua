local term = require 'toggleterm'

term.setup {
	size = 10,
	direction = 'float',
	float_opts = {
		border = 'curved'
	}
}

vim.keymap.set('n', [[<C-\>]], function()
	term.toggle()
end, {})

vim.keymap.set('t', [[<C-\>]], function()
	term.toggle()
end, {})

vim.keymap.set('n', [[<LEADER>te]], function ()
	vim.cmd [[ToggleTermSendCurrentLine]]
end)
