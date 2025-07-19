local context = require("treesitter-context")
context.setup {
	enable = true,
}
require 'nvim-treesitter.configs'.setup {
	ensure_installed = { "rust", "go", "c", "lua", "vim", "cpp" },
	ignore_install = { "" },
	modules = {},
	sync_install = false,
	auto_install = true,

	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<c-space>",
			node_incremental = "<c-space>",
			scope_incremental = "<c-s>",
			node_decremental = "<M-space>",
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					['aa'] = '@parameter.outer',
					['ia'] = '@parameter.inner',
					['af'] = '@function.outer',
					['if'] = '@function.inner',
					['ac'] = '@class.outer',
					['ic'] = '@class.inner',
				},
			},
			move = {
				enable = true,
				set_jumps = true,
				goto_next_start = {
					[']m'] = '@function.outer',
					[']]'] = '@class.outer',
				},
				goto_next_end = {
					[']M'] = '@function.outer',
					[']['] = '@class.outer',
				},
				goto_previous_start = {
					['[m'] = '@function.outer',
					['[['] = '@class.outer',
				},
				goto_previous_end = {
					['[M'] = '@function.outer',
					['[]'] = '@class.outer',
				},
			},
			swap = {
				enable = true,
				swap_next = {
					['<leader>a'] = '@parameter.inner',
				},
				swap_previous = {
					['<leader>A'] = '@parameter.inner',
				},
			},
		},
	}
}

vim.keymap.set("n", "[c", function() context.go_to_context() end, { silent = true });
vim.keymap.set("n", "<leader>tt", "<CMD>TSBufToggle highlight<CR>", { silent = true })
vim.keymap.set("n", "<leader>tu", "<CMD>TSCaptureUnderCursor<CR>", { silent = true })
