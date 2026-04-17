-- neogen: 함수, 클래스 등에 대한 주석(Annotation)을 자동으로 생성해주는 플러그인
return {
	"danymat/neogen",
	dependencies = "nvim-treesitter/nvim-treesitter",
	cmd = "Neogen",
	config = function()
		local i = require("neogen.types.template").item

		-- C++ 구현 코드에서 빠르게 읽기 좋은 간결형 프리셋
		local cpp_google_concise = {
			{ nil, "// $1", { no_results = true, type = { "func", "class", "type", "file" } } },
			{ nil, "// $1", { type = { "func", "class", "type", "file" } } },
			{
				i.Tparam,
				"//   %s: $1",
				{ type = { "func", "class" }, before_first_item = { "//", "// Template Args:" } },
			},
			{ i.Parameter, "//   %s: $1", { type = { "func" }, before_first_item = { "//", "// Args:" } } },
			{ i.Return, "// $1", { type = { "func" }, before_first_item = { "//", "// Returns:" } } },
		}

		require("neogen").setup({
			snippet_engine = "luasnip",
			languages = {
				cpp = {
					template = {
						annotation_convention = "doxygen",
						google_concise = cpp_google_concise,
					},
				},
				python = {
					template = {
						annotation_convention = "google_docstrings",
					},
				},
			},
		})
	end,
}
