-- tiny-inline-diagnostic: 진단 메시지를 더 예쁘게 인라인으로 보여주는 플러그인
return {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy", -- LSP가 로드된 후 실행되도록 설정
    priority = 1000,   -- 다른 UI 관련 플러그인보다 먼저 로드되도록 우선순위 부여
    config = function()
        require('tiny-inline-diagnostic').setup()
        -- 기본 진단 가상 텍스트 비활성화 (충돌 방지)
        vim.diagnostic.config({ virtual_text = false })
    end
}
