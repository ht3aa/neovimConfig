# My Config to LunarVim and Neovim


## Important
This configration configer lunarvim. It has 2 features that can work on any neovim or lunarvim environment. ProductivityTracker and VideoTracker

## How To Use Video Tracker
1. Add the videoTracker file to your config.
2. Add this code to your config

```
vim.cmd([[autocmd VimEnter * lua StartVideoTracker()]])
vim.cmd([[autocmd VimLeave * lua StopVideoTracker()]])
```

3. Require (tmux, ffmpeg) to be installed
4. Change the path of the videosPath variable whenver you want
5. Run tmux
6. Run your neovim or lunarvim
7. After done coding don't forget to quit from neovim or lunarvim using :qa (close the tmux or any other action make some errors)
8. Happy coding

## How To Use Productivity Tracker
1. Add the productivityTracker file to your config.
2. Change the path in line 33 to your desired path. This folder will contain files that stores data about your 
current productivity at specific project.
```
/mnt/hasanweb/programming/productivityTracker/ => /your/path/
```
3. Each projects your work on should contain .git folder to specify the root of your proejct.
<br />

that it you can work and whenver you leave your LunarVim or neovim environment. the data will saved
in the path you specifiy in csv format
```
year,month,day,hour,minute,second,typing time in seconds, path of the working project
```
