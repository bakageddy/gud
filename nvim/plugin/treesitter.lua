vim.pack.add({
	{
		src = 'https://github.com/nvim-treesitter/nvim-treesitter',
		branch = "main",
		build = ":TSUpdate",
	},
	'https://github.com/windwp/nvim-autopairs',
})

vim.api.nvim_create_autocmd("PackChanged", { callback = function (ev) 
	local name, kind = ev.data.spec.name, ev.data.kind
	if name == 'nvim-treesitter' and (kind == 'update' or kind == 'add') then
		-- if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
		vim.cmd("TSUpdate")
	end
end })

require('nvim-treesitter').setup {
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
