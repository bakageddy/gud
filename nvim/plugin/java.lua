vim.pack.add({
	"https://github.com/nvim-java/nvim-java"
})

require('java').setup({
	spring_boot_tools = {
		enable = false,
	},

	jdk = {
		auto_install = false,
		version = '21',
	},
})
