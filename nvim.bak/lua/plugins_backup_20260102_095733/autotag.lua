-- plugins/autotag.lua
return {
	"windwp/nvim-ts-autotag",
	ft = { "html", "xml", "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "svelte", "tsx", "jsx" },
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	opts = {
		opts = {
			-- Treesitter 기반 태그 자동 닫기 및 rename
			enable_close = true,
			enable_rename = true,
			enable_close_on_slash = true,
		},
	},
	config = function(_, opts)
		require("nvim-ts-autotag").setup(opts)
	end,
}
