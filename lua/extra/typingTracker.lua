ProductivityTrackerInSeconds = 0
local currentSecond
local time = os.time()
local timeOfLvimStart = os.time()
local timeTable = os.date("*t", time)
local time_spent_thinking_or_searching = 0
local time_spent_not_typing = os.time()
local second = timeTable.sec
local root_patterns = { ".git" }

currentSecond = second

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

local function get_diff_between_past_and_current_time(oldTime)
  local end_time = os.time()
  local diff_time = os.difftime(end_time, oldTime)

  return diff_time
end


function SaveCodeTracker()
  -- Retrieve day, hour, minute, and second
  local year = timeTable.year
  local month = timeTable.month
  local day = timeTable.day
  local hour = timeTable.hour
  local minute = timeTable.min
  local lastSecond = timeTable.sec

  -- Create a formatted string with the date and time information

  local rootFound = vim.fs.find(root_patterns, { upward = true })

  if rootFound[1] == nil then
    return
  end

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



  local function get_last_commit_info()
    local gitLogCommand = "git log -1 --pretty=format:'%h %s'"
    return execute_command(gitLogCommand)
  end

  local lastCommitInfo = get_last_commit_info()



  local dateTimeStr = string.format("%d,%d,%d,%d,%d,%d,%d,%d,%d,%s,%s,%s\n", year, month, day, hour, minute, lastSecond,
    ProductivityTrackerInSeconds, get_diff_between_past_and_current_time(timeOfLvimStart),
    time_spent_thinking_or_searching, root_dir, lastCommitInfo,
    FeatureName)

  if file then
    -- Append the formatted string to the file
    file:write(dateTimeStr)

    -- Close the file
    file:close()
  else
    print("Error opening the file for appending data.")
  end

end

local function trackKeyPressed()
  -- Get the current date and time
  time = os.time()

  -- Convert the current time to a table with individual components
  timeTable = os.date("*t", time)
  second = timeTable.sec

  if second < currentSecond then
    currentSecond = 0
  end

  if currentSecond < second then
    ProductivityTrackerInSeconds = ProductivityTrackerInSeconds + 1
    currentSecond = second
  end

end



local inputOpened = false;
local function checkIfHeIsThinkingOrSearching()
  local diff_time = get_diff_between_past_and_current_time(time_spent_not_typing)
  local userInput = ""
  if diff_time >= 60 then
    vim.schedule(function()
      if not inputOpened then
        inputOpened = true;
        userInput = vim.fn.input("was you thinking/searching or wasting time (y/n)? ")
      end

      if userInput == "y" then
        time_spent_thinking_or_searching = time_spent_thinking_or_searching + diff_time
      end
        inputOpened = false;
    end)
  end

  time_spent_not_typing = os.time()
end



vim.on_key(function()
  trackKeyPressed()
  checkIfHeIsThinkingOrSearching()
end)


