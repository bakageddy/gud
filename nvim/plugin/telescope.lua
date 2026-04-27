vim.pack.add({
	{src = 'https://github.com/nvim-telescope/telescope.nvim', branch = '0.1.x'},
	'https://github.com/nvim-telescope/telescope-file-browser.nvim',
})

local telescope = require('telescope')
local builtin = require("telescope.builtin")

telescope.setup {
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
		file_browser = {
			theme = "ivy",
		}
	},
	pickers = {
		live_grep = {
			theme = "ivy"
		}
	}
}

-- telescope.load_extension('fzf')
telescope.load_extension('file_browser')

vim.keymap.set("n", "<LEADER>tf", function() builtin.find_files({ hidden = true, case_mode }) end, {})
vim.keymap.set("n", "<LEADER>tn", function() builtin.find_files({ cwd = "~/.config", hidden = true, noignore = true }) end,
	{})
vim.keymap.set("n", "<LEADER>tg", function() builtin.live_grep() end, {})
vim.keymap.set("n", "<LEADER>tz", function() builtin.current_buffer_fuzzy_find() end, {})
vim.keymap.set("n", "<LEADER>tb", function() builtin.buffers() end, {})
vim.keymap.set("n", "<LEADER>tc", function() builtin.colorscheme() end, {})
vim.keymap.set("n", "<LEADER>tx", function() telescope.extensions.file_browser.file_browser() end)
vim.keymap.set("n", "<LEADER>to", function() builtin.oldfiles() end, {})
