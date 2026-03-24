-- docker-compose LSP 설정
return function()
  local compose_files = {
    "docker-compose.yml",
    "docker-compose.yaml",
    "compose.yaml",
    "compose.yml",
  }

  return {
    filetypes = { "yaml.docker-compose" },
    root_markers = compose_files,
  }
end
