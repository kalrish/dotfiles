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

vim.api.nvim_set_keymap(
	"v",
	"<Tab>",
	">gv",
	{
		noremap = true
	}
)

vim.api.nvim_set_keymap(
	"v",
	"<S-Tab>",
	"<gv",
	{
		noremap = true
	}
)
