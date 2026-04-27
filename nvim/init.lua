require("options")
require("keymaps")

vim.pack.add({"https://github.com/nvim-lua/plenary.nvim"})
local packadd = function (module)
	vim.cmd("packadd " .. module)
end
packadd("plenary.nvim")

