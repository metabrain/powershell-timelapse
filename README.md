powershell-timelapse
====================

A simple script for timelapsing applications (such games) in Windows using Powershell!
Watch here in 1080p the result of this script using Europa Universalis IV on a dual monitor setup : http://youtu.be/lLEOny65nkg

FEATURES
========
- Lightweight timelapse of applications (almost no memory footprint or slowdown)
- Tweakable interval, just change the value (in seconds)
- Powershell script will close when the application is closes
- If the application window view is obstructed by another view, no screenshot is taken (skips to next screenshot)
- If the application is not the active window, screenshot will not be taken (because it's probably obstructed anyway)
- All images are saved as PNGs for maximum quality

TESTED ON
=========
- Football Manager 2012 - Windowed mode (6 seasons, or 80GBs worth of JPGs)
- Don't Starve - Windows mode again...

UNTESTED
========
- Full screen mode? Never tested it because I don't play in full screen but should work...
- Games using anything other than DirectX

REQUIREMENTS
============
- Powershell (Windows 7+)
- (NOW INCLUDED AS A FOLDER FOR EASY USE) WASP plugin for Powershell (http://wasp.codeplex.com/)

HOW TO USE
==========
*Function Start-TimeLapse ($exe, $savedir, $waiting_time)*

Invoke directly from the command line giving the path to the executable, 
fodler to store timelapses and the number of seconds between each picture.

. .\timelapse.ps1 //reads the functions in the script
Start-TimeLapse(

Since this is too tiresome, you can easily adapt the shortcut for your favorite game to 
automatically fire this script! Imagining a normal game shortcut, click in Properties and
it should have the following :

- Target: "C:\PATH_TO_GAME\game.exe"
- Start in: "C:\PATH_TO_GAME\" //normaly same folder as above

1. Put the contents of this project (timelapse.ps1 and the WASP folder) in the folder listed in "Start in:" (e.g.: the folder of the game containing the executable!)
2. Change target to : (don't forget to change the Powershell path if yours is different!) 
  %SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe -command "& { . .\timelapse.ps1; Start-TimeLapse '.\game.exe' 'D:\TimeLapses\' 10 }"
3. Apply and save settings.
3. Now just double-click on the shortcut. Powershell will open, launch your game/application and start saving screenshots to "D:\TimeLapses\NAME_OF_GAME_EXECUTABLE\"!

You can, of course, change the timelapse folder to any you want, just don't forget to create it before launching the script.
Also, the "10" above is the number of seconds between each screenshot. I don't recommend lower because it will take too much space on your HDD after some hours playing!

HOW TO MAKE A VIDEO FROM ALL THOSE SCREENSHOTS
==============================================

After some hours, you will have millions of screenshots. Most video software I used crashed with so many files (Sony Vegas for one). The way I recommend is using **ffmpeg***.

1. Install **ffmpeg** (in Windows: http://www.wikihow.com/Install-FFmpeg-on-Windows)
2. Use ffmpeg ! (read this tutorial to know more http://www.itforeveryone.co.uk/image-to-video.html)

Personally, I use the following. 10 screenshots per second is good for a fast, but still understandable timelapse IMHO.

    ffmpeg -r 10 -i PREFIX_%016d.jpg -c:v libx264 -r 30 -pix_fmt yuv420p OUTPUT_FILE.mp4







Enjoy!
