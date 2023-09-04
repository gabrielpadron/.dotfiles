local M = {}

function M.setup()
    M.general()
    M.movements()
end

function M.general()
    vim.keymap.set("n", "n", "nzzzv")
    vim.keymap.set("n", "N", "Nzzzv")
    vim.keymap.set("n", "J", "mzJ`z")
    vim.keymap.set("i", ",", ",<c-g>u")
    vim.keymap.set("i", ".", ".<c-g>u")
    vim.keymap.set("i", "!", "!<c-g>u")
    vim.keymap.set("i", "?", "?<c-g>u")
    vim.keymap.set("v", "J", ":m .+1<cr>gv=gv", { silent = true })
    vim.keymap.set("v", "K", ":m .-2<cr>gv=gv", { silent = true })

    vim.keymap.set("n", "<leader>w", ":<C-U>bprevious <bar> bdelete #<CR>", { silent = true })
    vim.keymap.set("n", "<TAB>", ":bnext<CR>", { silent = true })
    vim.keymap.set("n", "<S-TAB>", ":bprevious<CR>", { silent = true })
    vim.keymap.set("n", "<Leader>b", ":BufferLinePick<CR>", { silent = true })
    vim.keymap.set("n", "cn", "*``cgn", { silent = true })
    vim.keymap.set("n", "cN", "*``cgN", { silent = true })

    vim.keymap.set("v", "<", "<gv", { desc = "Dedent current selection" })
    vim.keymap.set("v", ">", ">gv", { desc = "Indent current selection" })
    vim.keymap.set("n", "/", "ms/", { desc = "Keeps jumplist after forward searching" })
    vim.keymap.set("n", "?", "ms?", { desc = "Keeps jumplist after backward searching" })
    vim.keymap.set("n", "Q", "<Nop>", { desc = "Remove annoying exmode" })
    vim.keymap.set("n", "q:", "<Nop>", { desc = "Remove annoying exmode" })
    vim.keymap.set("n", "c", '"_c')
    vim.keymap.set("n", "C", '"_C')
    vim.keymap.set("n", "s", '"_s')
    vim.keymap.set("n", "S", '"_S')
    vim.keymap.set("n", "c_", '"_c^')
    vim.keymap.set("n", "d_", '"_d^')
    vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")
    vim.keymap.set("n", "<C-Down>", ":resize +2<CR>")
    vim.keymap.set("n", "<C-Up>", ":resize -2<CR>")
    vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
    vim.keymap.set("v", "p", "P")

    vim.keymap.set('n', '<Leader>,', 'A,<ESC>', { silent = true })
    vim.keymap.set('n', '<Leader>;', 'A;<ESC>', { silent = true })

    vim.keymap.set("n", "<leader>/", ":%s//g<Left><Left>", { silent = false })
    vim.keymap.set("v", "<leader>/", ":s//g<Left><Left>", { silent = false })

    vim.keymap.set("n", "<leader>nh", ":nohlsearch<cr>", { silent = true })

    vim.keymap.set(
        "n",
        "<leader>e",
        ":NvimTreeToggle<cr>",
        { noremap = true, silent = true }
    )

    vim.keymap.set("n", "<leader>ff", ":Format<cr>", { silent = true })
    vim.keymap.set("n", "<leader>ft", ":FormatToggle<cr>", { silent = true })

    vim.keymap.set('n', ']g', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
    vim.keymap.set('n', '[g', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
    vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
end

function M.movements()
    vim.keymap.set("n", "<C-J>", "<C-W><C-J>")
    vim.keymap.set("n", "<C-K>", "<C-W><C-K>")
    vim.keymap.set("n", "<C-L>", "<C-W><C-L>")
    vim.keymap.set("n", "<C-H>", "<C-W><C-H>")
    vim.keymap.set({ "i", "v" }, "<C-J>", "<Esc><C-W><C-J>")
    vim.keymap.set({ "i", "v" }, "<C-K>", "<Esc><C-W><C-K>")
    vim.keymap.set({ "i", "v" }, "<C-L>", "<Esc><C-W><C-L>")
    vim.keymap.set({ "i", "v" }, "<c-H>", "<Esc><C-W><C-H>")
    vim.keymap.set("n", "H", "^", { silent = true })
    vim.keymap.set("n", "L", "$", { silent = true })
    vim.keymap.set("v", "H", "^", { silent = true })
    vim.keymap.set("v", "L", "$", { silent = true })
    vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
    vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
end

M.setup()
