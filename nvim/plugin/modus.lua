vim.pack.add({
	'https://github.com/miikanissi/modus-themes.nvim',
	-- NOTE: Only adding this here since, modus and oxocarbon are similar
	'https://github.com/nyoom-engineering/oxocarbon.nvim'
});

require("modus-themes").setup({
	line_nr_column_background = false,
	sign_column_background = false,
	hide_inactive_statusline = false,
	dim_inactive = false,
	on_colors = function (colors)
		colors.error = colors.red_intense
	end,
	on_highlights = function (highlight, _)
		highlight.Visual = { reverse = true }
		highlight.NeoTreeNormal = { link = "Normal" }
		highlight.NeoTreeNormalNC = { link = "Normal" }
		highlight.TabLineFill = { link = "Normal" }
	end
});

-- vim.cmd.colorscheme [[oxocarbon]]
