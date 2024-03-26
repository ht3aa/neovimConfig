# My Config to LunarVim and Neovim


## Important
This configration configer lunarvim. It has 2 features that can work on any neovim or lunarvim environment. typingTracker and VideoTracker
clone this repo to get everything ready. (it should works fine in linux systems)

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

## How To Use Typing Tracker
1. Add the typingTracker file to your config.
2. Add this code to your config
```
vim.cmd([[autocmd VimLeave * lua SaveCodeTracker()]])
```

3. install the cli by running "sudo npm install typingtracker" 
4. allow permission to the installed packege by first see the path of your npm global packages
```
npm root -g
```
this will output something like this "/usr/local/lib/node_modules"
then 
```
sudo chown -R <username> /usr/local/lib/node_modules/typingtracker
```

that it you can work and whenver you leave your LunarVim or neovim environment. format of the data

```
year,month,day,hour,minute,second,typing time in seconds, path of the working project, last commit msg, start of video tracker, end of video tracker
```
