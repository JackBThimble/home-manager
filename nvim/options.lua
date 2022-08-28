local options = {
	backup = false,
	clipboard = "unnamedplus",
	cmdheight = 2,
	completeopt = { "menuone", "noselect" },
	conceallevel = 0,
	fileencoding = "utf-8",
	hlsearch = true,
	ignorecase = true,
	mouse = "a",
	pumheight = 10,
	showmode = false,
	showtabline = 2,
	smartcase = true,
	smartindent = true,
	splitbelow = true,
	splitright = true,
	swapfile = false,
	termguicolors = true,
	timeoutlen = 100,
	undofile = true,
	updatetime = 300,
	writebackup = false,
	expandtab = true,
	shiftwidth = 2,
	tabstop = 2,
	cursorline = true,
	number = true,
	relativenumber = true,
	numberwidth = 2,
	signcolumn = "yes",
	wrap = false,
	scrolloff = 8,
	sidescrolloff = 8,
	foldmethod = "expr",
	foldexpr = "nvim_treesitter#foldexpr()",
  foldlevel = 1,
	hidden = true,
	guifont = "monospace:h17",
}

vim.opt.shortmess:append "c"
vim.opt.shortmess:append "I"
vim.opt.whichwrap:append "<,>,[,],h,l"

for k, v in pairs(options) do
	vim.opt[k] = v
end



