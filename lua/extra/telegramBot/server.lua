-- Reference to the server job
Server_job = nil
local server_script_path = '/home/hasanweb/.config/lvim/lua/extra/telegramBot/server.js'
local client_script_path = '/home/hasanweb/.config/lvim/lua/extra/telegramBot/client.ts'
local root_patterns = { ".git" }
local rootFound = vim.fs.find(root_patterns, { upward = true })

local function is_server_running()
  -- Check if the server job is already running
  if Server_job then
    local status = vim.fn.jobwait({ Server_job }, 0)[1]
    return status > 0
  end
  return false
end

function Send_message_to_client(message)
  if is_server_running() then
    -- Send message to the server's stdin
    vim.fn.chansend(Server_job, message)
  else
    -- print(is_server_running())
  end
end

-- Function to start the server
local function start_server()
  -- Check if the server job is already running
  if is_server_running() then
    print("Server is already running.")
    return
  end

  vim.fn.jobstart({ 'node', client_script_path })
  -- vim.fn.jobstart({ 'node', client_script_path })
  -- Spawn a Node.js process running server.js script

  Server_job = vim.fn.jobstart({ 'node', server_script_path }, {
    on_stdout = function(_, data)
      local msg = table.concat(data, "\n")
      if (string.find(msg, "@ht3aa")) then
        vim.notify(msg:gsub("@ht3aa", ""), 'info', {
          title = 'Telegram Bot notification',
        })

        require("telescope").load_extension("notify")
        vim.cmd(":Telescope notify")
      end
    end,
    on_stderr = function(_, data)
      for _, line in ipairs(data) do
        print(line)
      end
    end,
  })
end

-- Function to check if the server job is running

-- Function to stop the server
function Stop_server()
  if is_server_running() then
    vim.fn.jobstop(Server_job)
    Server_job = nil
    print("Server stopped.")
  end
end

-- Invoke function to start the server
start_server()

-- Autocommand to stop the server when Vim quits
vim.cmd([[autocmd VimLeavePre * lua Stop_server()]])
