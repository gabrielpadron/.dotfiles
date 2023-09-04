local M = {
    "nvim-tree/nvim-tree.lua",
    lazy = true,
    cmd = {
        "NvimTreeFindFile",
        "NvimTreeFocus",
        "NvimTreeOpen",
        "NvimTreeRefresh",
        "NvimTreeToggle",
    },
    config = true
}

function M.config()
    local status_ok, nvim_tree = pcall(require, "nvim-tree")
    if not status_ok then
        return
    end

    nvim_tree.setup {
        disable_netrw = true,
        hijack_netrw = true,
        open_on_tab = false,
        hijack_cursor = false,
        update_cwd = true,
        diagnostics = {
            enable = true,
            icons = {
                hint = "",
                info = "",
                warning = "",
                error = "",
            },
        },
        update_focused_file = {
            enable = true,
            update_cwd = true,
            ignore_list = {},
        },
        system_open = {
            cmd = nil,
            args = {},
        },
        filters = {
            dotfiles = false,
            custom = {},
        },
        renderer = {
            root_folder_label = ":t",
            icons = {
                glyphs = {
                    default = "",
                    symlink = "",
                    bookmark = "",
                    folder = {
                        arrow_closed = "",
                        arrow_open = "",
                        default = "󰉋",
                        open = "",
                        empty = "",
                        empty_open = "",
                        symlink = "",
                        symlink_open = "",
                    },
                    git = {
                        unstaged = "✗",
                        staged = "✓",
                        unmerged = "",
                        renamed = "➜",
                        untracked = "★",
                        deleted = "",
                        ignored = "◌",
                    },
                },
            },
        },
        git = {
            enable = true,
            ignore = true,
            timeout = 500,
        },
        view = {
            width = 30,
            hide_root_folder = false,
            side = "left",
            -- mappings = {
            -- 	custom_only = false,
            -- },
            number = false,
            relativenumber = false,
        },
        trash = {
            cmd = "trash",
            require_confirm = true,
        },
    }

    vim.api.nvim_create_autocmd("BufEnter", {
        callback = function()
            if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match "NvimTree_" ~= nil then
                vim.cmd.quit()
            end
        end,
    })
end

return M
