Total_productivity_seconds = 0
local char = 0
local time = os.time()
local timeOfLvimStart = os.time()
local time_spent_thinking_or_searching = 0
local time_spent_not_typing = os.time()
local root_patterns = { ".git" }
Language_table = {}


local rootFound = vim.fs.find(root_patterns, { upward = true })

if rootFound[1] == nil then
  vim.fn.input("not a git repo. make it now to record your productivity")
  return
end


local function execute_command(command)
  local handle = io.popen(command)

  if not handle then return nil end

  local result = handle:read("*a")
  handle:close()
  return result
end

local function get_last_commit_info()
  local gitLogCommand = "git log -1 --pretty=format:'%h %s'"
  return execute_command(gitLogCommand)
end

local function get_diff_between_past_and_current_time(oldTime)
  local end_time = os.time()
  local diff_time = os.difftime(end_time, oldTime)

  return diff_time
end


function SaveTypingTracker()
  if rootFound[1] == nil then
    return
  end

  local timeTable = os.date("*t", time)
  -- Retrieve day, hour, minute, and second
  local year = timeTable.year
  local month = timeTable.month
  local day = timeTable.day
  local hour = timeTable.hour
  local minute = timeTable.min
  local lastSecond = timeTable.sec
  local buffer_table_str = ""
  for key, value in pairs(Language_table) do
    print(key .. "=" .. value)
    buffer_table_str = buffer_table_str .. key .. "=" .. value .. "$%#"
  end


  buffer_table_str = string.sub(buffer_table_str, 1, -4)


  local root_dir = vim.fs.dirname(rootFound[1])
  -- Split the path string by directory separator "/"
  local parts = {}
  for part in root_dir:gmatch("[^/]+") do
    table.insert(parts, part)
  end

  -- Retrieve the last directory
  local lastFile = parts[#parts]

  -- Open the file in append mode
  local file = io.open("/mnt/hasanweb/programming/workFiles/" .. lastFile .. ".csv", "a")




  local lastCommitInfo = get_last_commit_info()



  local dateTimeStr = string.format("%d,%d,%d,%d,%d,%d,%d,%d,%d,%s,%s,%s\n", year, month, day, hour, minute, lastSecond,
    Total_productivity_seconds, get_diff_between_past_and_current_time(timeOfLvimStart),
    time_spent_thinking_or_searching, root_dir, lastCommitInfo, buffer_table_str)

  if file then
    -- Append the formatted string to the file
    file:write(dateTimeStr)

    -- Close the file
    file:close()
  else
    print("Error opening the file for appending data.")
  end
end

local inputOpened = false;
local function checkIfHeIsThinkingOrSearching()
  local diff_time = get_diff_between_past_and_current_time(time_spent_not_typing)
  local userInput = ""
  if diff_time >= 180 then
    vim.schedule(function()
      if not inputOpened then
        inputOpened = true;
        userInput = vim.fn.input("was you thinking/searching (y/n)? ")
      end

      if userInput == "y" then
        time_spent_thinking_or_searching = time_spent_thinking_or_searching + diff_time
      end
      inputOpened = false;
    end)
  end

  time_spent_not_typing = os.time()
end



local function update_buffer_productivity()
  local current_buffer = vim.api.nvim_get_current_buf()
  local buffer_path = vim.api.nvim_buf_get_name(current_buffer)

  if buffer_path == "" then
    return
  end

  local buffer_path_parts = vim.split(buffer_path, "/")
  local file = buffer_path_parts[#buffer_path_parts]
  local file_parts = vim.split(file:lower(), "%.")
  local file_type = file_parts[#file_parts]

  if file_type == "" or file_type == nil then
    return
  end

  if Language_table[file_type] == nil then
    Language_table[file_type] = 1
  else
    Language_table[file_type] = Language_table[file_type] + 1
  end
end

function Update_typing_productivity_seconds()
  checkIfHeIsThinkingOrSearching()
  local diff_time = get_diff_between_past_and_current_time(time)
  char = char + 1

  if diff_time == 1 and char >= 5 then
    update_buffer_productivity()
    Total_productivity_seconds = Total_productivity_seconds + diff_time
    char = 0
    time = os.time()
  elseif diff_time > 1 then
    time = os.time()
    char = 0
  end
end
