ProductivityTrackerInSeconds = 0
local currentSecond
local time = os.time()
local timeTable = os.date("*t", time)
local second = timeTable.sec
local root_patterns = { ".git" }

currentSecond = second


  local function execute_command(command)
    local handle = io.popen(command)

    if not handle then return nil end

    local result = handle:read("*a")
    handle:close()
    return result
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
  local file = io.open("/tmp/typingtracker/workFiles/" .. lastFile .. ".csv", "a")



  local function get_last_commit_info()
    local gitLogCommand = "git log -1 --pretty=format:'%h %s'"
    return execute_command(gitLogCommand)
  end

  local lastCommitInfo = get_last_commit_info()
  print("Last commit info: " .. lastCommitInfo)



  local dateTimeStr = string.format("%d,%d,%d,%d,%d,%d,%d,%s,%s,%s,%s\n", year, month, day, hour, minute, lastSecond,
    ProductivityTrackerInSeconds, root_dir, lastCommitInfo, StartVideoName, EndVideoName)

  if file then
    -- Append the formatted string to the file
    file:write(dateTimeStr)

    -- Close the file
    file:close()
    print("Data appended to file successfully.")
  else
    -- print("Error opening the file for appending data.")
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

  -- print("second: " .. second, "currentSecond: " .. currentSecond, "ProductivityTrackerInSeconds: " .. ProductivityTrackerInSeconds)
end

vim.on_key(function()
  trackKeyPressed()
end)


