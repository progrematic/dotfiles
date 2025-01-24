local OS = vim.loop.os_uname().sysname

return {
  { dir = OS == 'Windows' and '/mnt/c/Users/danie/Programming/nvim/present.nvim/' or nil },
  { dir = OS == 'Windows' and '/mnt/c/Users/danie/Programming/nvim/todoqf.nvim/' or nil },
}
