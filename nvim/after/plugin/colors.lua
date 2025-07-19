local kanagawa = require 'kanagawa'
local gruvbox = require 'gruvbox'
-- local modus = require "modus-themes"

local global_hl = function(group, settings)
	vim.api.nvim_set_hl(0, group, settings)
end

function ColorMe()
	-- local p = require("solarized.palette")
	-- local solarized_colors = p.get_colors()

	gruvbox.setup {
		terminal_colors = false,
		invert_selection = true,
		contrast = "hard",
		dim_inactive = false,
		transparent_mode = false,
		palette_overrides = {
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
			["@keyword"] = {fg = gruvbox.palette.bright_red, italic = true},
			IndentLine = {link = "Comment", bold = true},
			-- IndentLineCurrent = {fg = gruvbox.palette.light1},
			-- ["@keyword.type"] = { link = "Structure" },
			["@type.builtin"] = { link = "Special" },
		}
	}

	kanagawa.setup {
		overrides = function(_)
			return {
				Visual = { reverse = true },
				FloatBorder = { bg = "#1f1f28" },
				SignColumn = { fg = "#1f1f28", bg = "#1f1f28" }
			}
		end,
		theme = "dragon",
	}

	-- vim.o.background = 'light'
	vim.cmd.colorscheme [[gruvbox]]
	vim.api.nvim_set_hl(0, "Visual", {
		reverse = true,
	})
	global_hl("VisualNOS", {
		link = "Visual",
	})
	global_hl("SignColumn", {
		link = "Normal",
	})
	global_hl("@type.builtin", {
		link = "Type"
	})

end

ColorMe()
