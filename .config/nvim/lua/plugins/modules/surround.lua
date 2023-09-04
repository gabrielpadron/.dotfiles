return {
    'kylechui/nvim-surround',
    event = 'VeryLazy',
    dependencies = {
        'tpope/vim-surround',
    },
    config = function()
        require('nvim-surround').setup({})
    end,
}
