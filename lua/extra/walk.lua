local function start_timer()
  -- Define the interval in milliseconds (30 minutes = 30 * 60 * 1000 milliseconds)
  local interval = 1000 * 60 * 60 * 2

  -- Start the timer
  local timer = vim.loop.new_timer()

  if not timer then
    return
  end

  local function timer_callback()
    -- Call the function
    vim.notify("Go walk and think, Write Down the solutions. You will solve the problem faster", 'error', {
      title = 'Walk',
      timeout = 1000 * 30
    })
  end

  -- Start the timer initially
  timer:start(interval, interval, function()
    -- Call the timer callback function
    timer_callback()

    -- Reschedule the timer to run again after the interval
    timer:again()
  end)
end

-- Start the timer
start_timer()
