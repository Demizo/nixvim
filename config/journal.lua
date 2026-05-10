-- Command: :JournalToday
vim.api.nvim_create_user_command("JournalToday", function()
	local date = os.date("%Y_%m_%d")
	local path = "journals/" .. date .. ".md"

	local dir = vim.fn.fnamemodify(path, ":h")
	if vim.fn.isdirectory(dir) == 0 then
		vim.fn.mkdir(dir, "p")
	end

	if vim.fn.filereadable(path) == 0 then
		local f = io.open(path, "w")
		if f then f:close() end
	end

	vim.cmd("edit " .. path)
end, {})

-- Command: :JournalLast
vim.api.nvim_create_user_command("JournalLast", function()
	local journal_dir = "journals"
	local dir_path = vim.fn.expand(journal_dir)

	if vim.fn.isdirectory(dir_path) == 0 then
		print("Directory does not exist")
		return
	end

	local files = vim.fn.globpath(dir_path, "*.md", false, true)
	if #files == 0 then
		print("No .md files found in folder")
		return
	end

	local latest = nil
	for _, file in ipairs(files) do
		local name = vim.fn.fnamemodify(file, ":t")
		local date_str = name:match("(%d%d%d%d)[:_%-](%d%d)[:_%-](%d%d)")

		if date_str then
			local y, m, d = name:match("(%d%d%d%d)[:_%-](%d%d)[:_%-](%d%d)")
			local numeric = tonumber(y .. m .. d)
			if numeric and (not latest or numeric > latest.numeric) then
				latest = { numeric = numeric, file = file }
			end
		end
	end

	if not latest then
		print("No valid journal files found")
		return
	end

	vim.cmd("edit " .. latest.file)
end, {})

-- Command: :JournalTodos
vim.api.nvim_create_user_command("JournalTodos", function()
	local has_telescope, builtin = pcall(require, "telescope.builtin")
	if not has_telescope then
		print("Telescope is required for this command")
		return
	end

	builtin.grep_string({
		prompt_title = "TODO",
		search = "- [ ]",
		use_regex = false,
	})
end, {})

-- Command: :JournalSearch
vim.api.nvim_create_user_command("JournalSearch", function()
	local has_telescope, _ = pcall(require, "telescope")
	if not has_telescope then
		print("Telescope is required for this command")
		return
	end

	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local conf = require("telescope.config").values

	local journal_dir = vim.fn.expand("journals")
	if vim.fn.isdirectory(journal_dir) == 0 then
		print("Journals directory does not exist")
		return
	end

	local files = vim.fn.globpath(journal_dir, "*.md", false, true)

	if #files == 0 then
		print("No journal files found.")
		return
	end

	-- Sort reverse alphabetically (newest first based on YYYY_MM_DD)
	table.sort(files, function(a, b)
		return a > b
	end)

	pickers.new({}, {
		prompt_title = "Journals (Recent First)",
		finder = finders.new_table({
			results = files,
			entry_maker = function(entry)
				return {
					value = entry,
					display = vim.fn.fnamemodify(entry, ":t"), -- Show just the filename
					ordinal = vim.fn.fnamemodify(entry, ":t"), -- Filter based on the filename
					path = entry,
				}
			end,
		}),
		sorter = conf.generic_sorter({}),
	}):find()
end, {})

-- Helper function to get sorted absolute paths
local function get_sorted_journals()
	local journal_dir = vim.fn.expand("journals")
	local files = vim.fn.globpath(journal_dir, "*.md", false, true)

	-- Convert every path to an absolute path so it matches nvim_buf_get_name
	for i, file in ipairs(files) do
		files[i] = vim.fn.fnamemodify(file, ":p")
	end

	table.sort(files)
	return files
end

-- Command: :JournalPrev
vim.api.nvim_create_user_command("JournalPrev", function()
	local files = get_sorted_journals()
	-- Get the absolute path of the current buffer
	local current = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p")

	for i, file in ipairs(files) do
		if file == current then
			if i > 1 then
				vim.cmd("edit " .. files[i - 1])
			else
				print("First journal entry reached.")
			end
			return
		end
	end
	print("Current file not found in journals directory.")
end, {})

-- Command: :JournalNext
vim.api.nvim_create_user_command("JournalNext", function()
	local files = get_sorted_journals()
	-- Get the absolute path of the current buffer
	local current = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p")

	for i, file in ipairs(files) do
		if file == current then
			if i < #files then
				vim.cmd("edit " .. files[i + 1])
			else
				print("Latest journal entry reached.")
			end
			return
		end
	end
	print("Current file not found in journals directory.")
end, {})
