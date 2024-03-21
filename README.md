# My Config to LunarVim and Neovim


## Important
I made a productivity tracker which caclulate the time spent on typing in keyboard.
then store it in file inside the path "/mnt/hasanweb/programming/productivityTracker/".
Also I made a video tracker which record your screen whenver you use lunarvim using ffmpeg 


## How To Use Video Tracker
1. Add the videoTracker file to your config.
2. require (tmux, ffmpeg) to be installed
3. Change the path of the videosPath variable whenver you want
4. happy coding

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
