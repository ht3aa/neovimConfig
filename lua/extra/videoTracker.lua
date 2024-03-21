local videosPath = "/mnt/hasanweb/programming/videoTracker/"

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
  os.execute('tmux new-window -n videoTracker "' .. command .. '"')
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




function StartVideoTracker()
  createYearDirectoryIfNeeded()
  createMonthDirectoryIfNeeded()
  createDayDirectoryIfNeeded()

  local lastCommitInfo = get_last_commit_info()

  if lastCommitInfo == nil then
    lastCommitInfo = "null"
  end

  if not tmux_window_exists("videoTracker") then
    run_terminal_command_in_tmux(
      "ffmpeg -video_size 1366x768 -framerate 10 -f x11grab -i :1 -crf 40 -preset veryfast " .. videosPath ..
      os.date("%Y") ..
      "/" ..
      os.date("%m") ..
      "/" .. os.date("%d") .. "/" .. os.date("%H-%M-%S") .. "-" .. lastCommitInfo:gsub("%s", "-") .. ".mkv")
  else
    print("videoTracker window is already open.")
  end
end

function StopVideoTracker()
  run_terminal_command_in_tmux("pkill ffmpeg")
end


vim.cmd([[autocmd VimEnter * lua StartVideoTracker()]])
vim.cmd([[autocmd VimLeave * lua StopVideoTracker()]])
