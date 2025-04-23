require 'nvim-treesitter.configs'.setup {
	ensure_installed = { "c", "lua", "rust", "javascript", "graphql", "typescript" },
	highlight = {
		enable = true,
	},
}


-- Terraform Treesitter
-- :TSInstall hcl
