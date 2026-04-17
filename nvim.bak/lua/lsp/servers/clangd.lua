-- C/C++: clangd 설정 (clang-tidy 연동)
return {
  cmd = { "clangd", "--clang-tidy", "--background-index", "--completion-style=detailed" },
  init_options = {
    clangdFileStatus = true,
  },
}

