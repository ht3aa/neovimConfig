local function is_tmux_running()
  return os.getenv("TMUX") ~= nil
end

local function run_command(command)
  os.execute(command)
end

local function isWindowExist(name)
  local handle = io.popen('tmux list-windows')

  if handle == nil then
    return false
  end

  local result = handle:read("*a")
  handle:close()

  -- Check if the result contains the window name
  return string.match(result, name) ~= nil
end


function MapLazygit()
  if not isWindowExist("lazygit") then
    run_command("tmux new-window -n lazygit 'lazygit'")
  end

  run_command("tmux select-window -t lazygit")
end

if is_tmux_running() then
  lvim.builtin.which_key.mappings.g.g = { "<cmd>lua MapLazygit()<cr>", "Lazygit" }
end
