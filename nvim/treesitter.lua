local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup({
	ensure_installed = { "bash", "c", "c_sharp", "cmake", "comment", "commonlisp", "cpp", "css", "dart", "devicetree", "dockerfile", "dot", "elixir", "erlang", "fennel", "fish", "go", "gomod", "gowork", "graphql", "help", "hjson", "html", "http", "java", "javascript", "jsdoc", "julia", "kotlin", "llvm", "lua", "make", "markdown", "markdown_inline", "nix", "norg", "perl", "php", "pug", "python", "regex", "ruby", "rust", "sql", "svelte", "toml", "tsx", "typescript", "vim", "vue", "yaml", },
	ignore_install = { "" },
	highlight = {
		enable = true,
		disable = { "css" },
	},
	autopairs = {
		enable = true,
	},
	indent = { enable = true, disable = { "python", "css" } },
})
