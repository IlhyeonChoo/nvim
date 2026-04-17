-- ESLint (진단/코드액션 중심, 포맷은 Prettier 권장)
return {
  settings = {
    codeAction = { disableRuleComment = { enable = true, location = "separateLine" }, showDocumentation = { enable = true } },
    format = false,
    workingDirectory = { mode = "auto" },
    experimental = { useFlatConfig = true },
  },
}

