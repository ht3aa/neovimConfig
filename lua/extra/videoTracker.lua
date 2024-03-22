local videosPath = "/mnt/hasanweb/programming/videoTracker/"

local function get_user_input(message)
  -- Use vim.fn.input to prompt for user input
  local user_input = vim.fn.input(message)
  -- Check if user pressed cancel (returns nil)
  if user_input == nil then
    return "nil"
  end
  return user_input
end


local videoName = get_user_input("Enter video name: ")


-- Function to create a directory
local function createDirectory(directory)
  vim.fn.mkdir(directory)
end

-- Function to check if a directory exists
local function directoryExists(directory)
  return vim.fn.isdirectory(directory) == 1
end

-- Function to create a directory for the current year if it doesn't exist
local function createYearDirectoryIfNeeded()
  local currentYear = os.date("%Y")
  local path = videosPath

  if not directoryExists(path .. "/" .. currentYear) then
    createDirectory(path .. "/" .. currentYear)
  end
end

-- Function to create a directory for the current month if it doesn't exist
local function createMonthDirectoryIfNeeded()
  local currentMonth = os.date("%m")
  local currentYear = os.date("%Y")
  local path = videosPath .. currentYear

  if not directoryExists(path .. "/" .. currentMonth) then
    createDirectory(path .. "/" .. currentMonth)
  end
end

-- Function to create a directory for the current day if it doesn't exist
local function createDayDirectoryIfNeeded()
  local currentDay = os.date("%d")
  local currentMonth = os.date("%m")
  local currentYear = os.date("%Y")
  local path = videosPath .. currentYear .. "/" .. currentMonth

  if not directoryExists(path .. "/" .. currentDay) then
    createDirectory(path .. "/" .. currentDay)
  end
end


-- Check if directories for the current year, month, and day need to be created


local function run_terminal_command_in_tmux(command)
  os.execute(command)
end


local function tmux_window_exists(window_name)
  local handle = io.popen('tmux list-windows -F "#{window_name}"')
  if handle == nil then
    return false
  end
  for line in handle:lines() do
    if line == window_name then
      handle:close()
      return true
    end
  end
  handle:close()
  return false
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


function split(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
end

local function get_last_commit_id()
  -- Get the last commit info
  local commit_info = get_last_commit_info()

  -- Check if info was retrieved successfully
  if commit_info == nil then
    return "nil"
  end

  -- Split the info by space (assuming ID is first)
  local split_info = split(commit_info, "%s")

  -- Return the first element (assuming it's the ID)
  return split_info[1]
end



function StartVideoTracker()
  createYearDirectoryIfNeeded()
  createMonthDirectoryIfNeeded()
  createDayDirectoryIfNeeded()



  if not tmux_window_exists("videoTracker") then
    run_terminal_command_in_tmux(
      "tmux new-window -n videoTracker ffmpeg -video_size 1366x768 -framerate 10 -f x11grab -i :1 -crf 40 -preset veryfast " ..
      videosPath ..
      os.date("%Y") ..
      "/" ..
      os.date("%m") ..
      "/" ..
      os.date("%d") ..
      "/" .. os.date("%H-%M-%S") .. "_video_name_" .. videoName:gsub("%s", "_") .. ".mkv")
  else
    print("videoTracker window is already open.")
  end
end

function StopVideoTracker()
  run_terminal_command_in_tmux("tmux kill-window -t videoTracker")

  local lastCommitIdInfo = get_last_commit_id()

  if lastCommitIdInfo == nil then
    lastCommitIdInfo = "null"
  end

  execute_command("mv "
    ..
    videosPath ..
    "/" ..
    os.date("%Y") ..
    "/" ..
    os.date("%m") ..
    "/" ..
    os.date("%d") ..
    "/" ..
    os.date("%H-%M-%S") ..
    "_video_name_" ..
    videoName:gsub("%s", "_") ..
    ".mkv " ..
    videosPath ..
    "/" ..
    os.date("%Y") ..
    "/" ..
    os.date("%m") ..
    "/" ..
    os.date("%d") ..
    "/" .. os.date("%H-%M-%S") .. "_" .. lastCommitIdInfo .. "_video_name_" .. videoName:gsub("%s", "_") .. ".mkv")
end

vim.cmd([[autocmd VimEnter * lua StartVideoTracker()]])
vim.cmd([[autocmd VimLeave * lua StopVideoTracker()]])
