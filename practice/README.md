# Neovim 기능 연습 워크스페이스

이 디렉터리는 현재 Neovim 설정을 직접 사용해 보기 위한 독립 연습 공간이다.
실제 설정 로딩 경로에는 포함되지 않으므로 파일을 자유롭게 수정해도 된다.

주의: 백틱 키는 tmux 리더 키이므로 이 연습에서는 백틱 기반 Vim mark 이동을 사용하지 않는다.
mark 이동이 필요하면 ma로 mark를 만들고 'a로 돌아오는 방식만 사용한다.

## 빠른 시작

1. Neovim을 이 디렉터리에서 연다.

~~~sh
nvim practice/README.md
~~~

2. 파일 탐색은 <leader>fd 또는 LazyVim 기본 picker를 사용한다.
3. Python, C++, Lua, Markdown 파일을 차례로 열어 completion, hover, jump, diagnostics를 확인한다.

## 공통 연습

- Normal mode에서 gd, gr, K, <leader>ca를 사용해 정의 이동, 참조 검색, hover, code action을 확인한다.
- TODO(연습) 주석을 검색하고 quickfix 또는 picker로 이동한다.
- 함수 이름과 변수 이름 위에서 rename을 실행한다.
- 괄호, 따옴표, 함수 호출 인자를 대상으로 nvim-surround 동작을 연습한다.
- <leader>Bm, <leader>Bn, <leader>Bp로 bookmark를 만들고 이동한다.
- Oil은 <leader>fd로 열고 파일명 변경, 새 파일 생성 흐름을 확인한다.

## Python 연습

시작 파일: practice/python/nevipractice/cli.py

- nevipractice/pipeline.py에서 score_task 함수에 breakpoint를 걸고 DAP Launch file로 실행한다.
- diagnostic_examples 함수의 타입 불일치 위에서 diagnostics, hover, code action을 확인한다.
- normalize_title 또는 select_next_task 이름을 rename해 참조가 함께 바뀌는지 확인한다.
- Task 모델 위에서 completion과 go to definition을 확인한다.
- 테스트 실행:

~~~sh
cd practice/python
python3 -m unittest discover -s tests
python3 -m nevipractice.cli
~~~

## C++ 연습

시작 파일: practice/cpp/src/main.cpp

- task.hpp의 선언에서 gd로 task.cpp 구현으로 이동한다.
- ScoreTask 함수에서 Neogen을 실행해 함수 주석 생성을 연습한다.
- InspectDiagnostics 함수의 unused 변수 warning에서 diagnostics 이동을 연습한다.
- compile_flags.txt가 있으므로 clangd는 C++20 플래그를 바로 읽을 수 있다.
- 빌드 확인:

~~~sh
cd practice/cpp
cmake -S . -B build
cmake --build build
./build/neovim_practice
~~~

## Lua 설정 패턴 연습

시작 파일: practice/lua/plugin_spec.lua

- example_plugin_spec 함수에서 Lazy plugin spec 구조를 접고 펼쳐 본다.
- opts 함수의 opts.practice 필드에서 completion과 rename을 확인한다.
- create_practice_autocmd 함수에서 autocmd callback 구조를 읽고 event 필드 hover를 확인한다.
- <leader>pp는 예제 문자열일 뿐이며 실제 설정에 등록되지 않는다.

## Markdown 연습

시작 파일: practice/markdown/notes.md

- 제목 접기와 펼치기를 연습한다.
- [결정 기록](markdown/decision-log.md) 링크로 이동한 뒤 다시 돌아온다.
- 표 행을 추가하고 table-mode 정렬을 확인한다.
- 긴 문단을 목록으로 바꾸며 visual selection, indent, surround를 연습한다.
