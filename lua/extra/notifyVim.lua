function GitCommitNotify()
  vim.notify(
  "Make Sure to make git commit before starting any new feature\nAlso make sure to make commit before you close vim",
    "info", {
    title = "Git Commits",
    timeout = 1000 * 60 * 2,
  })
end

vim.cmd([[autocmd VimStart * lua GitCommitNotify()]])
