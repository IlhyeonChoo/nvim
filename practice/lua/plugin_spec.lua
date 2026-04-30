-- Neovim Lua 설정 파일에서 자주 쓰는 패턴을 연습하기 위한 예제다.
-- 실제 설정에는 자동으로 로드되지 않으므로 마음껏 수정해도 된다.

local M = {}

local state = {
  -- 연습 키: enabled와 last_file 위에서 K hover, gr references, <leader>cr rename을 확인한다.
  enabled = true,
  last_file = nil,
}

local function current_file()
  -- 연습 키: vim.api.nvim_buf_get_name 위에서 K로 Lua LS hover를 확인하고 gd로 정의 이동을 시도한다.
  local name = vim.api.nvim_buf_get_name(0)
  if name == "" then
    return "[No Name]"
  end
  return vim.fn.fnamemodify(name, ":~:.")
end

function M.toggle_practice_flag()
  -- 연습 키: 함수 이름 위에서 <leader>cr rename을 실행하고 example_plugin_spec의 참조 변화를 본다.
  state.enabled = not state.enabled
  state.last_file = current_file()
  vim.notify("연습 플래그: " .. tostring(state.enabled) .. " / " .. state.last_file)
end

function M.create_practice_autocmd()
  -- 연습 키: autocmd 블록에서 접기/펼치기와 Treesitter 구조 이동을 연습한다.
  local group = vim.api.nvim_create_augroup("practice_lua_patterns", { clear = true })

  vim.api.nvim_create_autocmd("BufEnter", {
    group = group,
    pattern = "*.practice.lua",
    callback = function(event)
      -- TODO(연습): event 테이블 위에서 hover와 field completion을 확인한다.
      -- 연습 키: event.event 위에서 K hover, <leader>ca code action 후보, ]d/[d diagnostics 이동을 확인한다.
      vim.b.practice_last_event = event.event
    end,
  })
end

function M.example_plugin_spec()
  -- 연습 키: 이 함수의 return 테이블에서 %, [{, ]} 같은 구조 이동과 surround를 연습한다.
  return {
    {
      "folke/snacks.nvim",
      keys = {
        {
          "<leader>pp",
          function()
            -- 연습 키: toggle_practice_flag 위에서 gd로 함수 정의로 이동하고 gr로 참조를 확인한다.
            M.toggle_practice_flag()
          end,
          desc = "Practice Toggle Flag",
        },
      },
      opts = function(_, opts)
        -- 연습 키: opts.practice를 입력하며 <Tab> completion과 <S-Tab> 이전 후보 이동을 확인한다.
        opts.practice = opts.practice or {}
        opts.practice.enabled = state.enabled
      end,
    },
  }
end

return M
