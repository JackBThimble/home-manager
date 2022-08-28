require('dressing').setup({
	input = {
		enabled = true,
		default_prompt = "Input:",
		prompt_align = "left",
		insert_only = true,
		start_in_insert = true,
		anchor = "SW",
		border = "rounded",
		relative = "cursor",
		prefer_width = 40,
		width = nil,
		max_width = { 140, 0.9 },
		min_width = { 20, 0.2 },
		winblend = { 10 },
		--[[ winhighlight = "", ]]
		mappings = {
			n = {
				["<Esc>"] = "Close",
				["<CR>"] = "Confirm",
			},
			i = {
				["<C-c>"] = "Close",
				["<CR>"] = "Confirm",
				["<Up>"] = "HistoryPrev",
				["<Down>"] = "HistoryNext",
			},
		},

		override = function(conf)
			-- This is the config that will be passed to nvim_open_win.
			-- Change values here to customize the layout
			return conf
		end,

		-- see :help dressing_get_config
		get_config = nil,
	},
	select = {
		enabled = true,
		backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
		trim_prompt = true,
		telescope = nil,
		fzf = {
			window = {
				width = 0.5,
				height = 0.4,
			},
		},
		nui = {
			position = "50%",
			size = nil,
			relative = "editor",
			border = {
				style = "rounded",
			},
			buf_options = {
				swapfile = false,
				filetype = "DressingSelect",
			},
			win_options = {
				winblend = 10,
			},
			max_width = 80,
			max_height = 40,
			min_width = 40,
			min_height = 10,
		},
		builtin = {
			anchor = "NW",
			border = "rounded",
			relative = "editor",
			winblend = 10,
			--[[ winhightlight = "", ]]
			width = nil,
			max_width = { 140, 0.8 },
			min_width = { 40, 0.2 },
			height = nil,
			max_height = 0.9,
			min_height = { 10, 0.2 },

			mappings = {
				["<Esc>"] = "Close",
				["<C-c>"] = "Close",
				["<CR>"] = "Confirm",
			},

			override = function(conf)
				-- This is the config that will be passed to nvim_open_win.
				-- Change values here to customize the layout
				return conf
			end,
		},

		format_item_override = {},
		get_config = nil,
	},
})
