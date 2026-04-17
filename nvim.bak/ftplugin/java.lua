-- Java: nvim-jdtls로 파일 열 때마다 attach
-- Mason 경로를 기반으로 jdtls 실행 파일/설정을 계산합니다.

local ok, jdtls = pcall(require, "jdtls")
if not ok then
  return
end

local home = vim.env.HOME
local mason = vim.fn.stdpath("data") .. "/mason"
local jdtls_root = mason .. "/packages/jdtls"

-- 플랫폼별 설정 디렉터리
local system
local uname = vim.loop.os_uname().sysname
if uname == "Darwin" then
  system = "config_mac"
elseif uname == "Windows_NT" then
  system = "config_win"
else
  system = "config_linux"
end

-- launcher jar 검색
local launcher = vim.fn.glob(jdtls_root .. "/plugins/org.eclipse.equinox.launcher_*.jar")
if launcher == nil or launcher == "" then
  -- mason 설치가 안 되어 있으면 조용히 빠짐
  return
end

-- workspace 디렉터리: 프로젝트 루트명 기준
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if not root_dir or root_dir == "" then
  root_dir = vim.fn.getcwd()
end
local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

-- 공통 LSP 설정
local capabilities = require("lsp.common").capabilities
local on_attach = require("lsp.common").on_attach

local cmd = {
  "java",
  "-Declipse.application=org.eclipse.jdt.ls.core.id1",
  "-Dosgi.bundles.defaultStartLevel=4",
  "-Declipse.product=org.eclipse.jdt.ls.core.product",
  "-Dlog.protocol=true",
  "-Dlog.level=ALL",
  "-Xms1g",
  "--add-modules=ALL-SYSTEM",
  "--add-opens", "java.base/java.util=ALL-UNNAMED",
  "--add-opens", "java.base/java.lang=ALL-UNNAMED",
  "-jar", launcher,
  "-configuration", jdtls_root .. "/" .. system,
  "-data", workspace_dir,
}

local settings = {
  java = {
    signatureHelp = { enabled = true },
    completion = { favoriteStaticMembers = {} },
    contentProvider = { preferred = "fernflower" },
    configuration = { updateBuildConfiguration = "interactive" },
  },
}

local jdtls_config = {
  cmd = cmd,
  root_dir = root_dir,
  settings = settings,
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    -- jdtls 전용 키맵/명령은 필요 시 여기 추가 가능
  end,
}

jdtls.start_or_attach(jdtls_config)

