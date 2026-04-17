# AI_ONBOARDING.md

이 문서는 이 Neovim 설정 저장소를 AI가 빠르게 이해하기 위한 단일 진입 문서다.
기본적으로 이 파일 하나만 읽고 작업을 시작해도 된다.

## 0) 최근 변경 요약 (2026-02-15 기준)

- `bafa.nvim` 제거
- `oil.nvim`, `hardtime.nvim` 추가
- `iwe.nvim` + `iwes` 사용 구성 추가
- `iwe` 관련 파일은 로컬 전용으로 `.gitignore` 처리
  - `lua/plugins/iwe.lua`
  - `.iwe/`, `**/.iwe/`
- 키맵 정리:
  - 대부분 `lua/keymaps.lua`로 통합
  - `obsidian` 키맵은 `lua/plugins/obsidian.lua`의 `keys`에 유지
  - keymap `desc`는 영어-only 항목을 한국어로 정리
- `neogen` C++ 주석 프리셋 2종 추가
  - Doxygen 엄격형
  - Google 간결형(커스텀)

## 1) 프로젝트 한 줄 요약

- Lazy.nvim 기반 Neovim 설정.
- 구조는 `공통 설정` + `플러그인 파일 분리` + `LSP 서버별 분리` 패턴.
- 한국어 주석/문서가 많고, 사용자 쉘은 `zsh (oh-my-zsh)`.

## 2) 디렉토리 구조 (핵심만)

```text
init.lua                    # 진입점 (lazy 부트스트랩 + 공통 모듈 로드)
lazy-lock.json              # 플러그인 lockfile
lua/
  options.lua               # 전역 옵션
  keymaps.lua               # 전역 키맵
  filetypes.lua             # 파일타입/들여쓰기/formatoptions 정책
  lsp/
    common.lua              # LSP 공통 on_attach/capabilities
    clang_helpers.lua       # .clang-tidy 스캐폴드 커맨드
    servers/*.lua           # 서버별 옵션
  plugins/*.lua             # 플러그인 스펙 (1 파일 = 1 단위)
ftplugin/
  java.lua                  # jdtls start_or_attach
  markdown.lua              # markdown 전용 키맵/옵션
snippets/
  tex.json                  # scissors 기반 tex 스니펫
```

## 3) 시작 시 로딩 흐름

`init.lua` 기준:

1. `mapleader = " "` 설정
2. `lazy.nvim` 부트스트랩
3. `require("lazy").setup("plugins", {})` 실행
4. 공통 모듈 로드:
   - `options`
   - `keymaps`
   - `filetypes`
   - `lsp.clang_helpers`
5. 컬러스킴 이후 하이라이트 오버라이드 적용
   - 주석 색 `#ffff00`
   - 투명 배경 관련 하이라이트 처리

## 4) 설정 철학 / 컨벤션

- 플러그인 추가는 `lua/plugins/<name>.lua`에 작성.
- 키맵은 두 군데:
  - 공통/조합 키맵: `lua/keymaps.lua`
  - 플러그인 전용 엔트리 키맵: 각 플러그인 spec의 `keys`
- LSP 공통 로직은 `lua/lsp/common.lua`에만 둔다.
- 서버별 차이는 `lua/lsp/servers/<server>.lua`로 분리.
- 포맷팅 우선순위는 `conform.nvim` 중심.
- Web 계열 LSP 포맷은 대체로 꺼두고(HTML/CSS/TS/JS), Prettier/Conform에 위임.
- 로컬 전용 실험/개인 플러그인은 `.gitignore` 또는 `.git/info/exclude`로 추적 제외 가능.

## 5) 현재 핵심 스택

### 기본 UX

- 테마/UI: `catppuccin`, `lualine`, `noice`, `notify`, `which-key`
- 파일 탐색:
  - `neo-tree` (`<leader>fo`, `<leader>ff`)
  - `oil.nvim` (`<leader>fd`)
- 버퍼/탭: `barbar`, `harpoon`
- 검색: `fzf-lua` (`<leader>fs`, `<leader>fg`, `<leader>fb`, `<leader>fh`)

### 코드 인텔리전스

- LSP: `mason` + `mason-lspconfig` + `nvim-lspconfig`
- 자동완성: `nvim-cmp` + `cmp-nvim-lsp` + `LuaSnip`
- 문서/심볼: `aerial`, `symbols-outline`
- 진단 UI: `tiny-inline-diagnostic`, `trouble`

### 코드 품질

- 포맷터: `conform.nvim`
- 툴 설치 자동화: `mason-tool-installer`
- 문법 기반 하이라이트: `nvim-treesitter`
- 편집 보조: `autopairs`, `Comment.nvim`, `nvim-surround`, `neotab`
- 습관 교정: `hardtime.nvim`

### 개발 워크플로

- Git: `gitsigns`, `neogit`, `diffview`
- 디버깅: `nvim-dap`, `dap-ui`, `mason-nvim-dap`
- 마크다운/노트: `mkdnflow`, `render-markdown`, `markdown-preview`, `vim-table-mode`, `obsidian`, `iwe`, `pastify`
- 기타: `toggleterm`, `auto-session`, `vimtex`, `osc52`

## 6) LSP 동작 핵심 포인트

- `lua/plugins/nvim-lspconfig.lua`가 설치된 서버 목록을 읽어서 일괄 enable.
- `jdtls`는 예외:
  - 일반 루프에서 스킵
  - `ftplugin/java.lua`에서 `start_or_attach`로 관리
- C/C++는 `ccls` 바이너리가 있으면 `clangd` 대신 `ccls` 선호.
- `lua/lsp/common.lua`에서 공통 키맵과 inlay hint 활성화.

## 7) 파일타입 정책 핵심

`lua/filetypes.lua`에서 관리:

- Makefile: hard tab(8), `expandtab = false`
- Go: tab 기반(8)
- Java/C#: 4-space
- C/C++/ObjC/CUDA: 2-space
- JS/TS/HTML/CSS: 2-space + `formatoptions`에서 `c/r/o` 제거
- Python: 4-space

## 8) 자주 쓰는 키맵 (핵심만)

- 파일/검색:
  - `<leader>fo`: neo-tree toggle (right)
  - `<leader>ff`: neo-tree focus (right)
  - `<leader>fd`: oil 열기
  - `<leader>fs`: 파일 검색
  - `<leader>fg`: 전체 grep
- 노트:
  - Obsidian 단축키(`<leader>z...`)는 `lua/plugins/obsidian.lua`에서 관리
  - IWE는 명령 기반 사용 (`:IWE init`, `:IWE find_files`, `:IWE grep` 등)
- 주석 생성(Neogen):
  - `<leader>ng`: 기본 생성(현재 언어 기본 컨벤션)
  - `<leader>nd`: Doxygen 엄격형 프리셋
  - `<leader>nc`: Google 간결형 프리셋(C++), Python은 `google_docstrings` 유지
- Git:
  - `<leader>gg`: neogit
  - `<leader>gdo`: diffview open
  - `<leader>gdc`: diffview close
- 디버깅:
  - `<leader>db`: breakpoint toggle
  - `<leader>dc`: continue/start
  - `<leader>du`: dap ui toggle

## 9) AI가 수정할 때 체크리스트

1. 새 플러그인은 `lua/plugins/<name>.lua`에 추가.
2. 키맵 충돌 가능성을 `lua/keymaps.lua`와 기존 `keys`에서 함께 확인.
3. LSP 서버 추가 시:
   - `lua/plugins/mason.lua` `ensure_installed` 업데이트
   - `lua/lsp/servers/<name>.lua` 생성/수정
4. 포맷터 추가 시:
   - `lua/plugins/conform.lua`
   - 필요하면 `lua/plugins/mason-tool-installer.lua`도 같이 반영
5. 백업 파일/백업 폴더는 원칙적으로 수정 대상에서 제외:
   - `lua/plugins_backup_20260102_095733/`
   - `*.bak`, `*.backup`
6. 로컬 전용 플러그인/설정(iwe 등)은 Git 추적 여부를 먼저 확인:
   - 팀 공유 대상이면 `.gitignore`에서 제외하고 커밋
   - 개인 전용이면 `.gitignore` 또는 `.git/info/exclude` 유지

## 10) 알려진 주의사항

- `nvim-ts-autotag` 스펙 파일이 2개 존재:
  - `lua/plugins/autotag.lua`
  - `lua/plugins/nvim-ts-autotag.lua`
  중복 로딩/설정 병합 이슈 가능성이 있으니 관련 작업 시 먼저 정리 여부 판단 필요.

- `lazy-lock.json`은 플러그인 변경 후 diff가 자주 발생한다.
  플러그인 추가/삭제 작업에서는 lockfile 변경 의도 여부를 반드시 확인.

- `iwe`는 현재 로컬 전용 운영:
  - `.gitignore`에 `lua/plugins/iwe.lua`, `.iwe/`, `**/.iwe/` 등록됨
  - 공유 전환 시 ignore 규칙을 먼저 조정해야 함

## 11) 빠른 점검 명령

- 문법 체크:
  - `luac -p lua/plugins/<new-plugin>.lua`
- 참조 검색:
  - `rg -n "<keyword>" lua init.lua`
- 플러그인 파일 목록:
  - `ls -1 lua/plugins | sort`
- IWE 상태 점검:
  - `nvim --headless '+checkhealth iwe' '+qa'`

## 12) 관련 상세 문서 (필요할 때만)

- `NEW_PLUGINS_GUIDE.md` (fzf-lua, bookmarks, oil)
- `DEBUGGING_GUIDE.md` (DAP 상세)
- `GIT_WORKFLOW.md` (Git/Diffview 워크플로)
- `CLAUDE.md` (기존 요약 문서)
