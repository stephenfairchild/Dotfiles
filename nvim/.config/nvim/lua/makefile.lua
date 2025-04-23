-- makefile.lua
-- Configuration for handling Makefiles in Neovim
-- Place this file in ~/.config/nvim/lua/

-- Create autocommand groups for Makefile-specific settings
local makefile_group = vim.api.nvim_create_augroup("MakefileSettings", { clear = true })
local makefile_save_group = vim.api.nvim_create_augroup("MakefileSaveActions", { clear = true })

-- Set up autocmds for Makefile detection
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "Makefile", "makefile", "*.mk", "*.make" },
	group = makefile_group,
	callback = function()
		-- Set filetype to make if not already set
		if vim.bo.filetype ~= "make" then
			vim.bo.filetype = "make"
		end
	end,
})

-- Set up autocmds for Makefile settings that apply when filetype is detected as 'make'
vim.api.nvim_create_autocmd("FileType", {
	pattern = "make",
	group = makefile_group,
	callback = function()
		-- Use tabs, not spaces
		vim.bo.expandtab = false

		-- Set tab width to 8 (standard for Makefiles)
		vim.bo.tabstop = 8
		vim.bo.shiftwidth = 8

		-- Show tabs visually to help with debugging
		vim.wo.list = true
		vim.opt.listchars = { tab = "▸ ", trail = "·" }

		-- Highlight lines containing only spaces (common Makefile error)
		vim.cmd("highlight MixedIndentError ctermbg=red guibg=#FF0000")
		vim.fn.matchadd("MixedIndentError", "^ \\+\\t\\+")
		vim.fn.matchadd("MixedIndentError", "^\\t\\+ \\+")

		-- Optional: Set up a keybinding to convert leading spaces to tabs
		vim.keymap.set("n", "<leader>mt", function()
			-- Save cursor position
			local cursor_pos = vim.api.nvim_win_get_cursor(0)

			-- Get all lines in the buffer
			local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
			local new_lines = {}
			local changes_made = 0

			-- Process each line
			for i, line in ipairs(lines) do
				local new_line = line
				local indent = line:match("^( +)")

				if indent then
					-- Convert spaces to tabs (one tab per 8 spaces)
					local tabs = math.floor(#indent / 8)
					local remaining_spaces = #indent % 8

					if tabs > 0 then
						new_line = string.rep("\t", tabs) ..
						string.rep(" ", remaining_spaces) .. line:sub(#indent + 1)
						changes_made = changes_made + 1
					end
				end

				table.insert(new_lines, new_line)
			end

			-- Replace buffer content
			vim.api.nvim_buf_set_lines(0, 0, -1, false, new_lines)

			-- Restore cursor position
			vim.api.nvim_win_set_cursor(0, cursor_pos)

			-- Notify user
			vim.notify("Converted spaces to tabs in " .. changes_made .. " lines", vim.log.levels.INFO)
		end, { buffer = true, desc = "Convert spaces to tabs in Makefile" })

		-- Print a helpful message when a Makefile is opened
		vim.schedule(function()
			vim.notify("Makefile mode activated: Using tabs for indentation", vim.log.levels.INFO)
		end)
	end,
})

-- Create a user command to debug indentation in Makefiles
vim.api.nvim_create_user_command("MakefileCheckIndentation", function()
	local lines_with_spaces = {}
	for i = 1, vim.fn.line("$") do
		local line = vim.fn.getline(i)
		-- Check if line starts with spaces and is a command line (not a comment or variable)
		if line:match("^ +[^#]") and not line:match("^ +[%w_]+ *[+:]?=") then
			table.insert(lines_with_spaces, i)
		end
	end

	if #lines_with_spaces > 0 then
		vim.notify("WARNING: Lines with space indentation (should be tabs): " ..
			table.concat(lines_with_spaces, ", "), vim.log.levels.WARN)
	else
		vim.notify("No indentation issues found", vim.log.levels.INFO)
	end
end, {})

-- Function to fix "missing separator" errors
vim.api.nvim_create_user_command("MakefileFixSeparators", function()
	local problems = {}
	local linenr = 0
	local goto_line = nil

	-- Check for common Makefile errors
	for i = 1, vim.fn.line("$") do
		local line = vim.fn.getline(i)
		local next_line = i < vim.fn.line("$") and vim.fn.getline(i + 1) or ""

		-- Problem 1: Command line with spaces instead of tabs
		if line:match("^ +%S") and not line:match("^%s*#") and not line:match("^ +[%w_]+ *[+:]?=") then
			table.insert(problems, {
				line = i,
				issue = "Command line uses spaces instead of tabs",
				fix = "Convert spaces to tabs",
				fixfn = function()
					local indent = line:match("^( +)")
					local tabs = math.floor(#indent / 8)
					local remaining_spaces = #indent % 8
					local new_line = string.rep("\t", tabs) ..
					string.rep(" ", remaining_spaces) .. line:sub(#indent + 1)
					vim.api.nvim_buf_set_lines(0, i - 1, i, false, { new_line })
				end
			})
			if not goto_line then goto_line = i end
		end

		-- Problem 2: Target line missing a colon
		if not line:match("^%s") and not line:match("^%s*#") and not line:match(":") and
		    not line:match("^[%w_]+ *[+]?=") and
		    next_line:match("^%s") then
			table.insert(problems, {
				line = i,
				issue = "Target line missing a colon (:)",
				fix = "Add colon to the end of the line",
				fixfn = function()
					vim.api.nvim_buf_set_lines(0, i - 1, i, false, { line .. ":" })
				end
			})
			if not goto_line then goto_line = i end
		end

		-- Problem 3: Empty line between target and commands
		if i > 1 and line:match("^%s") and vim.fn.getline(i - 1):match("^%s*$") and i > 2 and vim.fn.getline(i - 2):match(":") then
			table.insert(problems, {
				line = i - 1,
				issue = "Empty line between target and commands (not allowed)",
				fix = "Remove empty line",
				fixfn = function()
					vim.api.nvim_buf_set_lines(0, i - 2, i - 1, false, {})
				end
			})
			if not goto_line then goto_line = i - 1 end
		end
	end

	-- Display and fix problems
	if #problems > 0 then
		local menu_items = {}
		for i, problem in ipairs(problems) do
			table.insert(menu_items, string.format("%d: Line %d - %s → %s",
				i, problem.line, problem.issue, problem.fix))
		end

		table.insert(menu_items, #problems + 1 .. ": Fix all issues")
		table.insert(menu_items, #problems + 2 .. ": Cancel")

		vim.ui.select(menu_items, {
			prompt = "Select issue to fix:",
		}, function(choice, idx)
			if not idx then return end
			if idx <= #problems then
				problems[idx].fixfn()
				vim.api.nvim_win_set_cursor(0, { problems[idx].line, 0 })
				vim.notify("Fixed issue " .. idx, vim.log.levels.INFO)
			elseif idx == #problems + 1 then
				-- Fix all issues (in reverse order to preserve line numbers)
				for i = #problems, 1, -1 do
					problems[i].fixfn()
				end
				vim.notify("Fixed all " .. #problems .. " issues", vim.log.levels.INFO)
			end
		end)

		-- Move cursor to the first problem
		if goto_line then
			vim.api.nvim_win_set_cursor(0, { goto_line, 0 })
		end
	else
		vim.notify("No common Makefile syntax issues found", vim.log.levels.INFO)
	end
end, {})

-- Function to fix Makefile indentation issues
local function fix_makefile_indentation()
	local lines_changed = 0
	local buffer_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local new_lines = {}

	for i, line in ipairs(buffer_lines) do
		local new_line = line

		-- Fix command lines with spaces instead of tabs
		if line:match("^%s+%S") and not line:match("^%s*#") and not line:match("^%s+[%w_]+%s*[+:]?=") then
			-- If line has leading spaces and looks like a command, convert to tab
			local content = line:match("^%s+(.*)$")
			if content then
				new_line = "\t" .. content
				lines_changed = lines_changed + 1
			end
		end

		table.insert(new_lines, new_line)
	end

	-- Only update if changes were made
	if lines_changed > 0 then
		vim.api.nvim_buf_set_lines(0, 0, -1, false, new_lines)
		vim.notify("Fixed " .. lines_changed .. " command line indentation issues", vim.log.levels.INFO)
	end
end

-- Set up autocmd to automatically fix indentation on save for Makefiles
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "Makefile", "makefile", "*.mk", "*.make" },
	group = makefile_save_group,
	callback = function()
		-- Only run on actual Makefiles
		if vim.bo.filetype == "make" then
			fix_makefile_indentation()
		end
	end,
})

-- This is not a plugin, just a module, so no need to return the function
return {}
