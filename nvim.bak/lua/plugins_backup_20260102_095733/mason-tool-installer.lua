-- mason-tool-installer: 포맷터/린터 등 Mason 툴 자동 설치
return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = { "williamboman/mason.nvim" },
	config = function()
		local ensure = {
			-- Conform에서 사용하는 포맷터들
			"isort",
			"black",
			"prettierd",
			"prettier",
			"eslint_d",
			"gofumpt",
			"goimports",
			"google-java-format",
			"clang-format",
			"cmakelang",
			"hadolint",
		}

		-- dotnet이 있을 때만 csharpier 설치 시도
		if vim.fn.executable("dotnet") == 1 then
			table.insert(ensure, "csharpier")
		end

		require("mason-tool-installer").setup({
			ensure_installed = ensure,
			auto_update = false,
			run_on_start = true,
			start_delay = 0,
		})
	end,
}
