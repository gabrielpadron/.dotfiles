local M = {}

function M.setup()
    M.globals()
    M.options()
    M.commands()
end

function M.globals()
    vim.g.mapleader = " "
end

function M.options()
    local options = {
        backup = false,            -- creates a backup file
        hidden = true,
        clipboard = "unnamedplus", -- allows neovim to access the system clipboard
        cmdheight = 1,             -- more space in the neovim command line for displaying messages
        completeopt = { "menuone", "noinsert", "noselect" },
        conceallevel = 0,          -- so that `` is visible in markdown files
        fileencoding = "utf-8",    -- the encoding written to a file
        hlsearch = true,           -- highlight all matches on previous search pattern
        incsearch = true,
        inccommand = "split",
        ignorecase = true,     -- ignore case in search patterns
        mouse = "a",           -- allow the mouse to be used in neovim
        pumheight = 10,        -- pop up menu height
        showmode = false,      -- we don't need to see things like -- INSERT -- anymore
        showtabline = 2,       -- always show tabs
        smartcase = true,      -- smart case
        smartindent = true,    -- make indenting smarter again
        splitbelow = true,     -- force all horizontal splits to go below current window
        splitright = true,     -- force all vertical splits to go to the right of current window
        swapfile = false,      -- creates a swapfile
        termguicolors = true,  -- set term gui colors (most terminals support this)
        timeoutlen = 300,      -- time to wait for a mapped sequence to complete (in milliseconds)
        undofile = true,       -- enable persistent undo
        updatetime = 250,      -- faster completion (4000ms default)
        writebackup = false,   -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
        expandtab = true,      -- convert tabs to spaces
        shiftwidth = 4,        -- the number of spaces inserted for each indentation
        tabstop = 4,           -- insert 2 spaces for a tab
        cursorline = true,     -- highlight the current line
        number = true,         -- set numbered lines
        relativenumber = true, -- set relative numbered lines
        numberwidth = 2,       -- set number column width to 2 {default 4}
        signcolumn = "yes",    -- always show the sign column, otherwise it would shift the text each time
        wrap = false,          -- display lines as one long line
        scrolloff = 12,        -- is one of my fav
        sidescrolloff = 12,
        path = ".,,**",
        laststatus = 0, -- disable status bar
        history = 1000,
        guicursor = { "i-ci:block-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100" },
        ruler = false, -- show the line and column number of the cursor position
        listchars = {
            tab = "!·",
            nbsp = "␣",
            trail = "·",
        },
        list = true,
        sessionoptions = {
            "blank",
            "buffers",
            "curdir",
            "tabpages",
            "winsize",
            "resize",
            "winpos",
            "terminal",
            "globals",
        },
        colorcolumn = tostring(79),
        splitkeep = "topline",
        fillchars = { eob = " " },
    }

    vim.opt.shortmess:append "cAIfs"
    vim.opt.spelloptions:append "noplainbuffer"
    vim.opt.whichwrap:append "<>[]hl"
    vim.g.loaded_netrwPlugin = 1
    vim.g.loaded_netrw = 1

    for k, v in pairs(options) do
        vim.opt[k] = v
    end
end

function M.commands()
    vim.cmd "set fsync"
    vim.cmd "set t_ZH=^[[3m"
    vim.cmd "set t_ZR=^[[23m"
    vim.cmd "set iskeyword+=-"
    vim.cmd("autocmd BufEnter * set formatoptions-=cro")
    vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")
    vim.cmd [[ :cab W w ]]
    vim.cmd [[ :cab Q q ]]

    vim.cmd [[ autocmd BufRead * autocmd FileType <buffer> ++once
      \ if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif]]
    vim.filetype.add {
        extension = {
            rasi = "css",
        },
    }

    local function open_nvim_tree(data)
        -- buffer is a directory
        local directory = vim.fn.isdirectory(data.file) == 1

        if not directory then
            return
        end

        -- change to the directory
        vim.cmd.cd(data.file)

        -- open the tree
        require("nvim-tree.api").tree.open()
    end

    vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
end

return M.setup()
