# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

> Primary single-source onboarding doc: `AI_ONBOARDING.md`

## 개요

이 저장소는 **Lazy.nvim** 기반 Neovim 설정이며, `~/dotfiles/nvim/.config/nvim/` 에 위치한다. 한국어 주석이 전반적으로 사용된다.

## 아키텍처

```
init.lua                    -- 진입점: Lazy.nvim 부트스트랩, 모듈 로드, 커스텀 하이라이트
lua/
├── plugins/                -- 플러그인별 Lazy spec 파일 (1 파일 = 1 플러그인)
├── lsp/
│   ├── common.lua          -- 공용 on_attach, capabilities (모든 LSP 서버가 공유)
│   ├── clang_helpers.lua   -- C/C++ 전용 헬퍼
│   └── servers/            -- 서버별 설정 (pyright, lua_ls, clangd, gopls 등)
├── options.lua             -- vim.opt 전역 설정
├── keymaps.lua             -- 플러그인 키매핑 중앙 관리
├── filetypes.lua           -- 파일타입별 설정
├── colors_dark.lua / colors_light.lua
└── basic/                  -- 탭/넘버링 초기화 유틸
ftplugin/                   -- 파일타입별 오버라이드 (java.lua, markdown.lua)
```

### 핵심 설계 패턴

- **플러그인 spec**: `lua/plugins/` 아래에 파일 하나당 플러그인 하나. `return { ... }` 형태로 Lazy.nvim spec을 반환한다.
- **LSP 설정 분리**: `lsp/common.lua`에서 `on_attach`와 `capabilities`를 정의하고, `lsp/servers/<name>.lua`에서 서버별 옵션만 기술한다. `nvim-lspconfig.lua`가 이를 조합하여 셋업한다.
- **Lazy loading**: 대부분 `event`, `cmd`, `ft`, `keys` 트리거로 지연 로드.
- **키매핑 이원화**: 플러그인 자체 키매핑은 spec의 `keys` 필드에, 그 외 전역 키매핑은 `keymaps.lua`에 집중.

### 주요 설정 결정사항

- **리더키**: Space
- **테마**: Catppuccin Mocha + 투명 배경 + 노란 주석(`#ffff00`)
- **검색**: fzf-lua (Telescope에서 마이그레이션됨)
- **포매터**: conform.nvim (언어별 포매터 지정)
- **버퍼 탭**: barbar.nvim, `Alt+숫자`로 이동 (사이드바 포커스 보존 래퍼 포함)
- **클립보드**: 로컬에서는 `unnamedplus`, SSH 환경에서는 osc52
- **들여쓰기**: tabstop=2, shiftwidth=2, expandtab

## 새 플러그인 추가 방법

1. `lua/plugins/<name>.lua` 파일 생성
2. Lazy.nvim spec을 `return { ... }` 형태로 작성
3. 의존성은 `dependencies` 필드에 명시
4. 가능하면 `event`/`cmd`/`ft`/`keys`로 지연 로드 설정

## 새 LSP 서버 추가 방법

1. `lua/lsp/servers/<name>.lua` 생성 — 서버 고유 옵션 테이블 반환
2. `lua/plugins/mason.lua`의 `ensure_installed` 목록에 추가
3. `lua/plugins/nvim-lspconfig.lua`에서 해당 서버 셋업 호출 (common.on_attach, common.capabilities 사용)

## 참고 문서

- `NEW_PLUGINS_GUIDE.md` — fzf-lua, vim-bookmarks, aerial 통합 가이드
- `DEBUGGING_GUIDE.md` — DAP 디버깅 설정
- `GIT_WORKFLOW.md` — Git 워크플로우
- `Consider.md` — 향후 도입 검토 플러그인 목록
