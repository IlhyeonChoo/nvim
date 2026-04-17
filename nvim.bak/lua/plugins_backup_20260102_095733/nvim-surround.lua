-- plugins/surround.lua
return {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {
        -- 기본 설정으로도 충분하며, 필요 시 여기에 키맵/동작 커스터마이즈
    },
    config = function(_, opts)
        require("nvim-surround").setup(opts)
        -- 사용 예시: ysiw"  -> 단어를 "로 감싸기,  cs"' -> "를 '로 변경, ds" -> " 제거
    end,
}
