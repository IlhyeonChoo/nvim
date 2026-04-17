-- plugins/aerial.lua
return {
	"stevearc/aerial.nvim",
	event = "LspAttach",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		backends = { "treesitter", "lsp", "markdown" },
		layout = { default_direction = "left", min_width = 28 },
		attach_mode = "global",
		show_guides = true,
		highlight_on_hover = true,
		manage_folds = true, -- zr/zm 등과 연동
		link_tree_to_folds = true,
		link_folds_to_tree = true,
		nerd_font = "auto",
		close_on_select = false,
		filter_kind = { "Class", "Function" }, -- 모두 표시(필요 시 { "Class", "Function" } 등으로 제한)
	},
	config = function(_, opts)
		local aerial = require("aerial")
		require("aerial").setup(opts)

		-- Telescope 확장 로드 (키맵은 keymaps.lua로 이동)
		pcall(function()
			require("telescope").load_extension("aerial")
		end)

        -- 자동 오픈 관련 동작 제거: 사용자가 원할 때만 열도록 유지

		-- lualine 연동은 중앙 설정(lua/plugins/lualine.lua)에서 처리
	end,
}
