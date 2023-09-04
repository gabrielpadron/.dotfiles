local M = {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    dependencies = {
        "nvim-lua/plenary.nvim",
        'tpope/vim-fugitive',
        'tpope/vim-rhubarb',
    },
}

function M.config()
    require("gitsigns").setup {
        signs = {
            add = { text = '' },
            change = { text = '' },
            delete = { text = '' },
            topdelete = { text = '' },
            changedelete = { text = '' },
            untracked = { text = 'U' }
        },
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = false,     -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false,    -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
            interval = 1000,
            follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
            delay = 1000,
            ignore_whitespace = false,
        },
        current_line_blame_formatter_opts = {
            relative_time = false,
        },
        max_file_length = 40000,
        preview_config = {
            -- Options passed to nvim_open_win
            border = "single",
            style = "minimal",
            relative = "cursor",
            row = 0,
            col = 1,
        },
        yadm = {
            enable = false,
        },


        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            local function w(func)
                return function()
                    func()
                    vim.defer_fn(function()
                        vim.cmd "NvimTreeRefresh"
                    end, 50)
                end
            end

            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, w(r), opts)
            end

            map("n", "]c", gs.next_hunk, { desc = "Next Hunk" })
            map("n", "[c", gs.prev_hunk, { desc = "Prev Hunk" })
            map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
            map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
            map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
            map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
            map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
            map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
            map("n", "<leader>hb", gs.toggle_current_line_blame, { desc = "Toggle current line blame" })
            map("n", "<leader>hd", gs.diffthis, { desc = "Diff this" })
            map({ "o", "x" }, "<leader>ih", gs.select_hunk, { desc = "Select hunk" })
        end,

        sign_priority = 6,
        update_debounce = 200,
        status_formatter = nil,
    }
end

return M
