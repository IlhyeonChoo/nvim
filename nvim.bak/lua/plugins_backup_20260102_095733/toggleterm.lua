-- toggleterm: Neovim 내에서 터미널을 열고 관리하는 플러그인
return {
  'akinsho/toggleterm.nvim',  -- 플러그인 repository
  version = "*",  -- 버전
  -- 키 매핑은 keymaps.lua에서 관리
  config = function()
    require("toggleterm").setup({
      size = 5,
      hide_numbers = true,  -- 넘버링 숨기기
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = false,  -- Insert 모드에서 단축키 비활성화 (keymaps.lua에서 관리)
      persist_size = true,
      direction = 'horizontal',  -- 기본 방향 설정 ('horizontal', 'vertical', 'tab' 중 선택)
      close_on_exit = true,  -- 터미널 프로세스 종료 시 터미널도 닫기
      shell = vim.o.shell,  -- 기본 쉘 사용
    })
  end,
  lazy = false,
}