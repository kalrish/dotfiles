vim.api.nvim_set_option(
	"ignorecase",
	true
)

vim.api.nvim_set_keymap(
	"n",
	",",
	":tabp<CR>",
	{
		noremap = true
	}
)

vim.api.nvim_set_keymap(
	"n",
	".",
	":tabn<CR>",
	{
		noremap = true
	}
)
