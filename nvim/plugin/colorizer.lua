vim.pack.add({'https://github.com/norcalli/nvim-colorizer.lua'});

local _ = require('colorizer').setup()
vim.keymap.set('n', '<LEADER>rc', vim.cmd.ColorizerToggle, {})
