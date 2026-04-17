-- plugins/auto-session.lua
return {
    "rmagatti/auto-session",
    lazy = false,
    event = "VimEnter",
    opts = {
        log_level = "error",
        auto_session_suppress_dirs = { "~/" },
        auto_restore_enabled = true,
        auto_save_enabled = true,
        auto_session_use_git_branch = true, -- 프로젝트 브랜치별 세션 분리
        cwd_change_handling = { restore_upcoming_session = true },
    },
}
