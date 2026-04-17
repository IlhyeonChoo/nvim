# Git & Diffview 사용 가이드

Neovim 설정에 포함된 Git 관련 플러그인(`gitsigns.nvim`, `neogit`, `diffview.nvim`)을 기반으로 자주 사용하는 흐름을 정리했습니다. 모든 리더키는 `<Space>`입니다.

## 1. 기본 Git 상태 확인
- **Gitsigns**
  - 라인 단위 변경 표시는 자동으로 활성화됩니다.
  - 주요 키맵
    - `]h` / `[h`: 다음/이전 hunk 이동
    - `<leader>hs` / `<leader>hr`: hunk stage/reset
    - `<leader>hb`: 현재 라인 blame 토글
    - `<leader>hd`: 현재 버퍼 vs HEAD diff

- **Neogit** (`<leader>gg`)
  - `Neogit` UI는 Magit 스타일의 커맨드 창입니다.
  - `s`로 stage, `u`로 unstage, `cc`로 커밋 버퍼 열기, `P`로 push 등 표준 Magit 키맵을 따릅니다.
  - 커밋 버퍼만 열고 싶으면 `<leader>gC` → 메시지 작성 후 저장(`:wq`)하면 커밋이 완료됩니다.

## 2. Diffview 열기/닫기/복귀
- Diffview는 별도 탭에서 diff를 보여주며, 닫으면 열기 전 레이아웃으로 돌아갑니다.

| 동작 | 키 또는 명령 | 설명 |
| --- | --- | --- |
| Diff 전체 열기 | `<leader>gdo` 또는 `:DiffviewOpen` | 현재 브랜치 vs 기본 브랜치(HEAD) diff |
| Diff 닫기 | `<leader>gdc` 또는 `:DiffviewClose` | Diffview 탭 종료 → 원래 창 구성 복원 |
| 파일 히스토리 | `<leader>gdf` 또는 `:DiffviewFileHistory` | 현재 파일/디렉터리 히스토리 탐색 |
| 파일 목록 토글 | `:DiffviewToggleFiles` | Diffview 탭 내에서 파일 패널 토글 |

▶ **열기 직전 상태로 복귀하려면** `:DiffviewClose` (또는 `<leader>gdc`)를 실행하세요. Diffview가 열릴 때 기존 창 정보를 저장했다가 닫을 때 복원하므로 추가 조작 없이 원래 편집 레이아웃으로 되돌아갑니다.

## 3. 실전 워크플로 예시
1. `<leader>gg`로 Neogit 상태 창을 열어 변경 사항 개요 확인. 
2. 필요하면 `s`로 hunk stage, `cc`로 커밋 버퍼 작성.
3. 커밋 전에 전체 변경을 보고 싶으면 `<leader>gdo`로 Diffview 열기 → 변경 내용 검토.
4. 확인 후 `<leader>gdc`로 Diffview 닫기 → 다시 Neovim 편집 레이아웃으로 복귀.
5. 커밋을 완료하고 `P`로 push 또는 다른 Git 명령 실행.

## 4. 자주 묻는 질문
- **Diffview가 계속 열린 채로 남아있을 때는?**<br>
  `:DiffviewClose`를 여러 번 실행해 모든 Diffview 탭을 닫을 수 있습니다. 탭이 여러 개라면 `:tabclose`로도 닫을 수 있지만, Diffview 명령을 사용하는 것이 가장 안전합니다.
- **특정 브랜치와 비교하고 싶을 때는?**<br>
  `:DiffviewOpen main`처럼 대상 브랜치를 지정하거나 `:DiffviewOpen HEAD~3` 등으로 커밋을 직접 지정할 수 있습니다.
- **Neogit에서 푸시/풀을 어떻게?**<br>
  상태 창에서 `P`로 push, `F`로 pull/etch 명령을 실행할 수 있습니다. 프롬프트가 뜨면 원하는 옵션을 선택하세요.

필요에 따라 추가 워크플로나 키맵이 생기면 이 문서를 계속 확장해도 좋습니다.

