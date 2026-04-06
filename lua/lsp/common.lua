local M = {}

local function map(bufnr, lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, {
    noremap = true,
    silent = true,
    buffer = bufnr,
    desc = desc,
  })
end

local function lsp_location_jump(method)
  return function()
    vim.lsp.buf[method]({ reuse_win = true })
  end
end

local python_navigation_capabilities = {
  "declarationProvider",
  "definitionProvider",
  "implementationProvider",
  "referencesProvider",
  "typeDefinitionProvider",
}

local function disable_capabilities(client, capability_names)
  for _, capability in ipairs(capability_names) do
    client.server_capabilities[capability] = false
  end
end

local function prefer_pyright_for_navigation(bufnr)
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  local pyright
  local pyrefly_clients = {}

  for _, attached_client in ipairs(clients) do
    if attached_client.name == "pyright" then
      pyright = attached_client
    elseif attached_client.name == "pyrefly" then
      table.insert(pyrefly_clients, attached_client)
    end
  end

  if not pyright or vim.tbl_isempty(pyrefly_clients) then
    return
  end

  for _, pyrefly in ipairs(pyrefly_clients) do
    disable_capabilities(pyrefly, python_navigation_capabilities)
  end
end

-- LSP 설정에 공통으로 적용할 on_attach 함수
M.on_attach = function(client, bufnr)
  if vim.bo[bufnr].filetype == "python" and (client.name == "pyright" or client.name == "pyrefly") then
    prefer_pyright_for_navigation(bufnr)
  end

  -- 일반적인 LSP 키 매핑
  map(bufnr, "gD", lsp_location_jump("declaration"), "LSP: 선언으로 이동")
  map(bufnr, "gd", lsp_location_jump("definition"), "LSP: 정의로 이동")
  map(bufnr, "gr", vim.lsp.buf.references, "LSP: 참조 목록")
  map(bufnr, "K", vim.lsp.buf.hover, "LSP: 호버")
  map(bufnr, "<C-k>", vim.lsp.buf.signature_help, "LSP: 시그니처 도움말")
  -- LSP 네임스페이스(<leader>l...)로 정리하여 사용자 키맵 충돌 방지
  map(bufnr, "<leader>la", vim.lsp.buf.add_workspace_folder, "LSP: 워크스페이스 추가")
  map(bufnr, "<leader>lr", vim.lsp.buf.remove_workspace_folder, "LSP: 워크스페이스 제거")
  map(bufnr, "<leader>ll", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "LSP: 워크스페이스 목록")
  map(bufnr, "<leader>ld", lsp_location_jump("definition"), "LSP: 정의로 이동")
  map(bufnr, "<leader>lD", lsp_location_jump("declaration"), "LSP: 선언으로 이동")
  map(bufnr, "<leader>li", lsp_location_jump("implementation"), "LSP: 구현으로 이동")
  map(bufnr, "<leader>lt", lsp_location_jump("type_definition"), "LSP: 타입 정의로 이동")
  map(bufnr, "<leader>lR", vim.lsp.buf.references, "LSP: 참조 목록")
  map(bufnr, "<leader>rn", vim.lsp.buf.rename, "LSP: 이름 변경")
  map(bufnr, "<leader>ca", vim.lsp.buf.code_action, "LSP: 코드 액션")
  map(bufnr, "<leader>lf", function()
    vim.lsp.buf.format({ async = true })
  end, "LSP: 포맷")

  -- Inlay hints 자동 활성화 (Neovim 0.9/0.10 호환)
  local ih = vim.lsp.inlay_hint
  local ok = ih ~= nil
  if ok then
    if type(ih) == "function" then
      pcall(ih, bufnr, true)
    elseif type(ih) == "table" and type(ih.enable) == "function" then
      pcall(ih.enable, true, { bufnr = bufnr })
    end
  end
end

-- LSP capabilities 향상
M.capabilities = require('cmp_nvim_lsp').default_capabilities()

return M
