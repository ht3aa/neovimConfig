local videosPath = "/mnt/hasanweb/programming/videoTracker/"

-- Define the set of characters to choose from
local charset = "1234567890qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM"

-- Function to generate a random string of given length from the charset
local function random_string(length)
  math.randomseed(os.time()) -- Seed the random number generator
  local random_str = ""
  for _ = 1, length do
    local rand_index = math.random(1, #charset)
    random_str = random_str .. charset:sub(rand_index, rand_index)
  end
  return random_str
end

-- Function to prompt user for input and append a random string
local function get_user_input(message)
  -- Use vim.fn.input to prompt for user input
  local user_input = vim.fn.input(message)
  -- Check if user pressed cancel (returns nil)
  if user_input == nil then
    return "nil"
  end
  -- Append a random 10-character string from the charset
  user_input = user_input:gsub("%s", "_")
  return user_input
end


local function isLvimWindowExists()
  local handle = io.popen('tmux list-windows')

  if handle == nil then
    return false
  end

  local result = handle:read("*a")
  handle:close()

  local count = 0
  for _ in string.gmatch(result, "nvim") do
    count = count + 1
  end

  return count == 1
end

StartVideoName = get_user_input("Enter start video name: ")
EndVideoName = ""

local randomString = random_string(10)


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


local function split(inputstr, sep)
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
    run_terminal_command_in_tmux("tmux new-window -n videoTracker -c ")
    run_terminal_command_in_tmux(
      "tmux send-keys -t videoTracker 'ffmpeg -video_size 1366x768 -probesize 800M -framerate 10 -f x11grab -i :1 -crf 40 -preset veryfast " ..
      videosPath ..
      os.date("%Y") ..
      "/" ..
      os.date("%m") ..
      "/" ..
      os.date("%d") ..
      "/" .. randomString .. ".mkv' Enter")
  else
    print("videoTracker window is already open.")
  end
end

function StopVideoTracker()
  if not isLvimWindowExists() then
    return
  end
  run_terminal_command_in_tmux("tmux kill-window -t videoTracker")
  execute_command("pkill ffmpeg")

  local lastCommitId = get_last_commit_id()
  EndVideoName = get_user_input("Enter end video name: ")

  if lastCommitId == nil then
    lastCommitId = "null"
  end

  -- wait_one_second()

  run_terminal_command_in_tmux("tmux new-window -n changeVideoName -c "
    ..
    videosPath ..
    os.date("%Y") ..
    "/" ..
    os.date("%m") ..
    "/" ..
    os.date("%d"))

  run_terminal_command_in_tmux("tmux send-keys -t 'changeVideoName' 'mv " .. randomString .. ".mkv "
    ..
    os.date("%H-%M-%S") ..
    "_start_" ..
    StartVideoName ..
    "_end_" ..
    EndVideoName ..
    "_commit_" ..
    lastCommitId:gsub("%s", "_") .. "_project" .. vim.fn.getcwd():gsub("/", "_"):gsub("%.", "") .. ".mkv' Enter")



  run_terminal_command_in_tmux("tmux send-keys -t 'changeVideoName' 'tmux kill-window' Enter")
end


