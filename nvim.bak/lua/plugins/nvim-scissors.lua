-- nvim-scissors: 코드 스니펫을 쉽게 추가, 편집, 삭제할 수 있도록 도와주는 플러그인
return {
	"chrisgrieser/nvim-scissors",
	dependencies = "nvim-telescope/telescope.nvim", -- optional
	opts = {
		snippetDir = "/Users/eshaj/.config/nvim/snippets"
	}
}