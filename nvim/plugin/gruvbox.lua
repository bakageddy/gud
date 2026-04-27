vim.pack.add({
	'https://github.com/ellisonleao/gruvbox.nvim',
})

local gruvbox = require 'gruvbox'
gruvbox.setup {
	terminal_colors = false,
	invert_selection = true,
	contrast = "hard",
	dim_inactive = false,
	transparent_mode = false,
	palette_overrides = {
		-- dark0_hard = "#000000",
		-- red = "#ff5f5f",
		-- bright_red = "#ff5f5f",
		light1 = "#d4be98",
		light0 = "#d4be98",
	},
	overrides = {
		TelescopePromptTitle = { fg = gruvbox.palette.dark0_hard, bg = gruvbox.palette.bright_orange },
		TelescopeTitle = { fg = gruvbox.palette.dark0_hard, bg = gruvbox.palette.bright_aqua },
		TelescopePreviewTitle = { fg = gruvbox.palette.dark0_hard, bg = gruvbox.palette.bright_yellow },
		TelescopePreviewBorder = { fg = gruvbox.palette.bright_yellow },
		TelescopeTitleBorder = { fg = gruvbox.palette.bright_aqua },
		TelescopePromptBorder = { fg = gruvbox.palette.bright_orange },
		FloatBorder = { bg = gruvbox.palette.dark0_hard },
		SignColumn = { fg = gruvbox.palette.dark0_hard, bg = gruvbox.palette.dark0_hard },
		["@punctuation.bracket"] = { fg = gruvbox.palette.bright_orange },
		["@module"] = { fg = gruvbox.palette.bright_aqua },
		["@namespace"] = { link = "@module" },
		["@keyword"] = { fg = gruvbox.palette.bright_red, italic = true },
		IndentLine = { link = "Comment", bold = true },
		IndentLineCurrent = {fg = gruvbox.palette.light1},
		["@keyword.type"] = { link = "Structure" },
		["@type.builtin"] = { link = "Special" },
	}
}
vim.cmd.colorscheme [[gruvbox]]
