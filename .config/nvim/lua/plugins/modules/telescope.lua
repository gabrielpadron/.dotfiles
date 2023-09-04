local M = {
	'nvim-telescope/telescope.nvim',
	version = '*',
	lazy = true,
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-telescope/telescope-fzf-native.nvim',
	}
}

function M.config()
	local actions = require "telescope.actions"

	require('telescope').setup {
		defaults = {
			vimgrep_arguments = {
				'rg',
				'--color=never',
				'--no-heading',
				'--with-filename',
				'--line-number',
				'--column',
				'--smart-case'
			},
			prompt_prefix = "  ",
			selection_caret = "  ",
			entry_prefix = "  ",
			initial_mode = "insert",
			selection_strategy = "reset",
			sorting_strategy = "ascending",
			layout_strategy = "horizontal",
			layout_config = {
				horizontal = {
					mirror = false,
				},
				vertical = {
					mirror = false,
				},
			},
			file_sorter = require 'telescope.sorters'.get_fzy_sorter,
			file_ignore_patterns = {},
			generic_sorter = require 'telescope.sorters'.get_generic_fuzzy_sorter,
			winblend = 0,
			border = {},
			borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
			color_devicons = true,
			use_less = true,
			path_display = {},
			set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
			file_previewer = require 'telescope.previewers'.vim_buffer_cat.new,
			grep_previewer = require 'telescope.previewers'.vim_buffer_vimgrep.new,
			qflist_previewer = require 'telescope.previewers'.vim_buffer_qflist.new,
			buffer_previewer_maker = require 'telescope.previewers'.buffer_previewer_maker,
			mappings = {
				i = {
					["<esc>"] = actions.close

				},
				n = {
					["<esc>"] = actions.close
				},
			},
		},

		pickers = {
			find_files = {
				theme = "dropdown"
			}
		},

		extensions = {
			fzy_native = {
				override_generic_sorter = false,
				override_file_sorter = true,
			}
		},
	}

	-- Enable telescope fzf native, if installed
	pcall(require('telescope').load_extension, 'fzf')
	-- Telescope
	vim.keymap.set("n", "<leader>p",
		"<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({previewer = false}))<cr>",
		opts)
	vim.keymap.set("n", "<leader>g",
		"<cmd>lua require('telescope.builtin').live_grep(require('telescope.themes').get_dropdown({}))<cr>", opts)
	vim.keymap.set("n", "<leader>o",
		"<cmd>lua require('telescope.builtin').treesitter(require('telescope.themes').get_dropdown({}))<cr>", opts)
	vim.keymap.set("n", "<leader>r",
		"<cmd>lua require('telescope.builtin').oldfiles(require('telescope.themes').get_dropdown({previewer = false}))<cr>",
		opts)
end

return M
