-- obsidian.nvim: Obsidian vault integration
local vault = vim.env.OBSIDIAN_VAULT or vim.fn.expand("~/Obsidian")
local fs = vim.uv or vim.loop

local function is_dir(path)
  local stat = fs.fs_stat(path)
  return stat and stat.type == "directory"
end

-- 주기별 노트 생성/열기 헬퍼
local function open_periodic_note(folder, filename, template)
  local dir = vault .. "/" .. folder
  if not is_dir(dir) then
    vim.fn.mkdir(dir, "p")
  end
  local filepath = dir .. "/" .. filename .. ".md"
  local is_new = not fs.fs_stat(filepath)
  vim.cmd("edit " .. vim.fn.fnameescape(filepath))
  if is_new and template then
    vim.schedule(function()
      vim.cmd("ObsidianTemplate " .. template)
    end)
  end
end

return {
  "epwalsh/obsidian.nvim",
  version = "*",
  enabled = function()
    return is_dir(vault)
  end,
  ft = "markdown",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = {
    "ObsidianNew",
    "ObsidianQuickSwitch",
    "ObsidianSearch",
    "ObsidianToday",
    "ObsidianBacklinks",
    "ObsidianTemplate",
    "ObsidianWeekly",
    "ObsidianMonthly",
    "ObsidianQuarterly",
    "ObsidianYearly",
  },
  keys = {
    { "<leader>zn", "<cmd>ObsidianNew<cr>", desc = "Obsidian: 새 노트" },
    { "<leader>zo", "<cmd>ObsidianQuickSwitch<cr>", desc = "Obsidian: 빠른 전환" },
    { "<leader>zs", "<cmd>ObsidianSearch<cr>", desc = "Obsidian: 검색" },
    { "<leader>zd", "<cmd>ObsidianToday<cr>", desc = "Obsidian: 데일리 노트" },
    { "<leader>zw", "<cmd>ObsidianWeekly<cr>", desc = "Obsidian: 위클리 노트" },
    { "<leader>zm", "<cmd>ObsidianMonthly<cr>", desc = "Obsidian: 먼슬리 노트" },
    { "<leader>zq", "<cmd>ObsidianQuarterly<cr>", desc = "Obsidian: 분기 노트" },
    { "<leader>zy", "<cmd>ObsidianYearly<cr>", desc = "Obsidian: 연간 노트" },
    { "<leader>zb", "<cmd>ObsidianBacklinks<cr>", desc = "Obsidian: 백링크" },
    { "<leader>zt", "<cmd>ObsidianTemplate<cr>", desc = "Obsidian: 템플릿 삽입" },
  },
  config = function()
    if not is_dir(vault) then
      return
    end

    require("obsidian").setup({
      workspaces = {
        { name = "notes", path = vault },
      },
      notes_subdir = "00 Inbox",
      new_notes_location = "notes_subdir",
      daily_notes = {
        folder = "10 Daily",
        date_format = "%Y-%m-%d",
        template = "데일리 노트 템플릿",
      },
      templates = {
        subdir = "90 Template",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
      },
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },
      note_id_func = function(title)
        local suffix = ""
        if title and title ~= "" then
          suffix = title:gsub("%s+", "-"):gsub("[^%w%-]", ""):lower()
        else
          suffix = tostring(os.time())
        end
        return os.date("%Y%m%d%H%M") .. "-" .. suffix
      end,
      note_frontmatter_func = function(note)
        local out = {
          id = note.id,
          aliases = note.aliases,
          tags = note.tags,
          created = os.date("%Y-%m-%d"),
        }
        if note.title then
          out.title = note.title
        end
        return out
      end,
    })

    local function create_user_command(name, callback, desc)
      if vim.fn.exists(":" .. name) == 2 then
        return
      end
      vim.api.nvim_create_user_command(name, callback, { desc = desc })
    end

    create_user_command("ObsidianWeekly", function()
      open_periodic_note("11 Weekly", os.date("%Y-W%V"), "weekly")
    end, "Obsidian: 위클리 노트")
    create_user_command("ObsidianMonthly", function()
      open_periodic_note("12 Monthly", os.date("%Y-%m"), "monthly")
    end, "Obsidian: 먼슬리 노트")
    create_user_command("ObsidianQuarterly", function()
      local q = math.ceil(tonumber(os.date("%m")) / 3)
      open_periodic_note("13 Quarterly", os.date("%Y") .. "-Q" .. q, "quarterly")
    end, "Obsidian: 분기 노트")
    create_user_command("ObsidianYearly", function()
      open_periodic_note("14 Yearly", os.date("%Y"), "yearly")
    end, "Obsidian: 연간 노트")
  end,
}
