require("presence"):setup({
                auto_update = true,  -- Enable auto-updating of Discord status
				neovim_image_text   = "The One True Text Editor",    -- Text displayed under the Neovim icon
				main_image          = "neovim",      -- Main image ("file" or "neovim")
				ipc					= {
					socket = "/run/user/$(id -u)/discord-ipc-0",
				},
				log_level			= nil,
				debounce_timeout	= 10,
				enable_line_number	= false,
				enable_time			= false,
				blacklist			= {},
				buttons				= true,
				file_attributes = {
					filename = false,
					project = false,
				},
    -- Rich Presence text options
				editing_text        = "Editing a file",-- Text when editing a file
				-- editing_text        = "Editing %s",-- Text when editing a file
				file_explorer_text  = "Neovim",-- Text when browsing a file
				git_commit_text     = "Neovim",-- Text when making a git commit
				plugin_manager_text = "Neovim",-- Text when managing plugins
				reading_text        = "Neovim", -- Text when in read-only mode
				line_number_text    = "Neovim", -- Line number text
				-- show_time			= false,
    })
