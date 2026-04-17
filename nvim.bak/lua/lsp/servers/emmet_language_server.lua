-- Emmet (HTML/CSS/JSX/TSX 확장)
return function()
  local filetypes = {
    "html",
    "css",
    "scss",
    "less",
    "javascriptreact",
    "typescriptreact",
    "javascript",
    "typescript",
    "astro",
    "svelte",
    "vue",
  }
  return {
    filetypes = filetypes,
    init_options = { showExpandedAbbreviation = "always" },
  }
end

