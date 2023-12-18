local banner = {
  [[                                                                         ]],
  [[ ██╗░░██╗░█████╗░░██████╗░█████╗░███╗░░██╗░██╗░░░░░░░██╗███████╗██████╗░ ]],
  [[ ██║░░██║██╔══██╗██╔════╝██╔══██╗████╗░██║░██║░░██╗░░██║██╔════╝██╔══██╗ ]],
  [[ ███████║███████║╚█████╗░███████║██╔██╗██║░╚██╗████╗██╔╝█████╗░░██████╦╝ ]],
  [[ ██╔══██║██╔══██║░╚═══██╗██╔══██║██║╚████║░░████╔═████║░██╔══╝░░██╔══██╗ ]],
  [[ ██║░░██║██║░░██║██████╔╝██║░░██║██║░╚███║░░╚██╔╝░╚██╔╝░███████╗██████╦╝ ]],
  [[ ╚═╝░░╚═╝╚═╝░░╚═╝╚═════╝░╚═╝░░╚═╝╚═╝░░╚══╝░░░╚═╝░░░╚═╝░░╚══════╝╚═════╝░ ]],
  [[                                                                         ]],
}

local bannerSmall = {
  [[                                        ]],
  [[ █░░█ █▀▀█ █▀▀ █▀▀█ █▀▀▄ █░░░█ █▀▀ █▀▀▄ ]],
  [[ █▀▀█ █▄▄█ ▀▀█ █▄▄█ █░░█ █▄█▄█ █▀▀ █▀▀▄ ]],
  [[ ▀░░▀ ▀░░▀ ▀▀▀ ▀░░▀ ▀░░▀ ░▀░▀░ ▀▀▀ ▀▀▀░ ]],
  [[                                        ]],
}

lvim.builtin.alpha.dashboard.section.header = {
  type = "text",
  val = function()
    local alpha_wins = vim.tbl_filter(function(win)
      local buf = vim.api.nvim_win_get_buf(win)
      return vim.api.nvim_buf_get_option(buf, "filetype") == "alpha"
    end, vim.api.nvim_list_wins())

    if vim.api.nvim_win_get_height(alpha_wins[#alpha_wins]) < 36 then
      return banner
    end
    return banner
  end,
  opts = {
    position = "center",
    hl = "Label",
  },
}
