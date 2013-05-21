powershell-timelapse
====================

A simple script for timelapsing applications (such games) in Windows using Powershell!

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
- Football Manager 2012 - Windowed mode (6 seasons, or 80GBs worth of PNGs)
- Don't Starve - Windows mode again...

UNTESTED
========
- Full screen mode? Never tested it because I don't play in full screen but should work...
- Games anything other than DirectX

REQUIREMENTS
============
- WASP plugin for Powershell installed (http://wasp.codeplex.com/)
- Powershell (Windows 7+)

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

1. Put the timelapse.ps1 script in the folder listed in "Start in:" 
2. Change target to : (don't forget to change the Powershell path if yours is different!) 
  %SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe -command "& { . .\timelapse.ps1; Start-TimeLapse '.\game.exe' 'D:\TimeLapses\' 10 }"
3. Apply and save settings.
3. Now just double-click on the shortcut. Powershell will open, launch your game/application and start saving screenshots to "D:\TimeLapses\NAME_OF_GAME_EXECUTABLE\" !
You can change the timelapse folder to any you want, just don't forget to create it before launching the script!
