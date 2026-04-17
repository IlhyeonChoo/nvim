# 디버깅 사용 가이드

Neovim에서 C, C++, Python 프로젝트를 IDE처럼 디버깅할 수 있도록 `nvim-dap`, `nvim-dap-ui`, `nvim-dap-virtual-text`, `mason-nvim-dap`가 설정되어 있습니다. 이 문서는 디버거 설치부터 실제 사용 방법까지 정리한 안내서입니다.

## 1. 사전 준비
- Neovim을 열고 `:Mason` 명령으로 Mason UI를 띄운 뒤 다음 항목이 설치되어 있는지 확인합니다.
  - `codelldb` (C/C++ 디버거)
  - `python` (debugpy 기반 Python 디버거)
- 설치되지 않았다면 Mason UI에서 선택해 설치하거나 커맨드라인에서 아래 명령을 실행하세요.
  - `:MasonInstall codelldb python`
- Python 프로젝트에서 가상환경을 사용한다면 Neovim을 실행하기 전에 해당 가상환경을 활성화하거나 `:VenvSelect` 등 별도의 플러그인을 통해 활성화해야 합니다. 활성화된 가상환경은 자동으로 디버깅에 활용됩니다.

## 2. 공통 단축키 (리더키 = `<Space>`)
| 동작 | 키 | 설명 |
| --- | --- | --- |
| 중단점 토글 | `<leader>db` | 현재 줄에 중단점 설정/해제 |
| 조건부 중단점 | `<leader>dB` | 조건식을 입력해서 중단점을 설정 |
| 로그 포인트 | `<leader>dl` | 조건 대신 로그 메시지를 출력하도록 설정 |
| 실행/계속 | `<leader>dc` | 디버깅 세션 시작 또는 이어서 실행 |
| 다음 줄 실행 | `<leader>dn` | Step Over |
| 함수 내부로 이동 | `<leader>di` | Step Into |
| 함수 밖으로 이동 | `<leader>do` | Step Out |
| 커서까지 실행 | `<leader>dr` | Run to Cursor |
| 마지막 구성 재실행 | `<leader>ds` | 이전에 사용한 디버그 설정으로 즉시 실행 |
| 세션 종료 | `<leader>dq` | 디버깅 중단 |
| 값 평가 | `<leader>de` | Normal/Visual 모드에서 선택한 코드 분석 |
| DAP UI 토글 | `<leader>du` | 사이드바/REPL/panel 열고 닫기 |

디버깅을 시작하면 자동으로 DAP UI 패널이 열리고, 세션 종료 시 닫히도록 설정되어 있습니다.

## 3. Python 디버깅
1. 디버깅할 Python 파일을 연 상태에서 `<leader>dc`를 눌러 디버깅을 시작합니다.
2. 첫 실행 시 아래와 같은 프로파일을 선택할 수 있습니다.
   - **Launch file**: 현재 열려 있는 파일을 그대로 실행합니다.
   - **Launch module**: `python -m <module>`과 동일하게 모듈 이름을 입력해 실행합니다.
   - **Attach (localhost)**: 이미 실행 중인 debugpy 서버(예: `debugpy.listen(5678)`)에 접속합니다.
3. 가상환경이 활성화되어 있으면 해당 환경의 Python 인터프리터가 자동으로 사용됩니다.
4. REPL 패널에서 표현식을 평가하거나 `<leader>de`로 코드 조각을 즉시 확인할 수 있습니다.

## 4. C/C++ 디버깅
1. 디버그 빌드로 실행 파일을 먼저 컴파일합니다. (예: `cmake --build build -j` 또는 `clang++ main.cpp -g -o main`)
2. 디버깅할 소스 파일을 연 뒤 중단점을 설정하고 `<leader>dc`를 누릅니다.
3. **Launch executable** 구성에서는 실행 파일 경로를 묻습니다. 기본값은 현재 작업 디렉터리이므로, `build/app`처럼 상대 경로를 입력하세요.
4. 실행 인자가 필요하면 공백으로 구분해 입력합니다.
5. 이미 실행 중인 프로세스에 붙으려면 `<leader>dc` 실행 후 `Attach to process` 구성을 선택하면 됩니다. 프로세스 목록이 표시되며 선택하면 attach합니다.

## 5. 디버깅 UI 구성 요소
- **Scopes**: 현재 프레임의 변수들을 확인할 수 있는 패널입니다.
- **Breakpoints**: 등록된 중단점을 목록으로 보여줍니다.
- **Stacks**: 호출 스택을 확인할 수 있습니다.
- **Watches**: REPL에서 `watch` 명령을 사용하거나 `<leader>de`로 표현식을 추가하면 이 패널에서 추적됩니다.
- **REPL**: 디버거 콘솔 입력/출력을 확인하고 명령을 실행할 수 있습니다. 필요 시 `:lua require('dap').repl.open()`으로 별도 창을 열 수 있습니다.

UI가 닫혔을 때는 `<leader>du`로 다시 열 수 있으며, 패널 레이아웃은 dap-ui 설정(`lua/plugins/dap.lua`)에서 조정 가능합니다.

## 6. 문제 해결 팁
- 디버거가 시작되지 않을 경우 Mason에서 관련 어댑터가 제대로 설치되었는지 확인하세요.
- Python attach 모드를 사용하려면 대상 프로세스에서 `debugpy.listen(<port>)`을 호출한 뒤 `debugpy.wait_for_client()`로 연결을 기다리도록 설정해야 합니다.
- C/C++ 프로젝트에서 심볼이 보이지 않는다면 `-g` 옵션으로 컴파일했는지 확인하세요.
- 로그 확인이 필요하면 dap-ui 하단의 콘솔이나 Neovim 메시지 영역을 살펴보세요.

이 문서를 참고해 원하는 언어에서 브레이크포인트 기반 디버깅을 편하게 진행해 보세요!

