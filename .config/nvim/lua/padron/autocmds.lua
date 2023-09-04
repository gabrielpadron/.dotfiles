local function highlight_on_yank()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 100 }
end

vim.api.nvim_create_autocmd("TextYankPost", { callback = highlight_on_yank })

vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "BufEnter" }, {
    group = vim.api.nvim_create_augroup("ScrollEOF", {}),
    pattern = "*",
    callback = function()
        local win_h = vim.api.nvim_win_get_height(0)
        local off = math.min(vim.o.scrolloff, math.floor(win_h / 2))
        local dist = vim.fn.line "$" - vim.fn.line "."
        local rem = vim.fn.line "w$" - vim.fn.line "w0" + 1
        if dist < off and win_h - rem + dist < off then
            local view = vim.fn.winsaveview()
            view.topline = view.topline + off - (win_h - rem + dist)
            vim.fn.winrestview(view)
        end
    end,
})

local cc_default_hi = vim.api.nvim_get_hl_by_name("ColorColumn", true)
vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "BufEnter" }, {
    group = vim.api.nvim_create_augroup("CCHighlight", {}),
    pattern = "*",
    callback = function()
        local cc = tonumber(vim.api.nvim_win_get_option(0, "colorcolumn"))
        if cc ~= nil then
            local lines = vim.api.nvim_buf_get_lines(0, vim.fn.line "w0", vim.fn.line "w$", true)
            local max_col = 0
            for _, line in pairs(lines) do
                max_col = math.max(max_col, vim.fn.strdisplaywidth(line))
            end
            if max_col <= cc then
                vim.api.nvim_set_hl(0, "ColorColumn", cc_default_hi)
            else
                vim.api.nvim_set_hl(0, "ColorColumn", { bg = cc_default_hi.background + 328968 })
            end
        end
    end,
})

-- TODO: turn to lua functions using nvim.api
vim.cmd [[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
    autocmd FileType qf set nobuflisted

    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') | NvimTreeOpen | wincmd p | endif
  augroup end

  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell
  augroup end

  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd =
  augroup end

  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end
]]
