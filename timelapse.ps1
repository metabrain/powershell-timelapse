## Export-Screenshot to take a screenshot and save it to disk
#####################################################################################
## Usage:
##   Export-Screenshot sshot.png
##   Export-Screenshot screen.jpg (New-Object Drawing.Rectangle 0, 0, 640, 480)
##	 Start-TimeLapse "D:\Jogos\Football Manager 2012\fm.exe" "D:\TimeLapses\" 1 
##		(time delay between screenshots)
#####################################################################################

Add-PSSnapin WASP

# Get a screenshot as a bitmap      
function Get-Screenshot ([Drawing.Rectangle]$bounds) {
   $screenshot = new-object Drawing.Bitmap $bounds.width, $bounds.height
   $graphics = [Drawing.Graphics]::FromImage($screenshot)
   # $bounds.Location.Offset(50,50)
   $graphics.CopyFromScreen( $bounds.Location, [Drawing.Point]::Empty, $bounds.size)
	$graphics.Dispose()
   return $screenshot
}

# Save a screenshot to file
function Export-Screenshot {
PARAM (
   [string]$FilePath, 
   [Drawing.Rectangle]$bounds = [Windows.Forms.SystemInformation]::VirtualScreen
)
   write-host "FilePath: $($FilePath)" -fore green

   # Fix paths, in case they don't set [Environment]::CurrentDirectory
   if(!(split-path $FilePath).Length) { 
      $FilePath = join-path $pwd (split-path $FilePath -leaf)
      Write-Host "FilePath: $($FilePath)" -fore magenta
   }
   
   write-host "FilePath: $($FilePath)" -fore cyan

   $screenshot = Get-Screenshot $bounds
   #get-member -inputobject $screenshot
   $screenshot.Save( $($FilePath) )
   $screenshot.Dispose()
   gci $FilePath
}

#receives executable path, path to save timelapse to and the time between screenshots by parameter
#EXAMPLE IN WINDOWS SHORTCUT
# %SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe -command "& { . .\timelapse.ps1; Start-TimeLapse '.\dontstarve_steam.exe' 'D:\TimeLapses\' 10 }"
Function Start-TimeLapse ($exe, $savedir, $waiting_time)
{
	#constant and global stuff, loading stuff etc
	$null = [Reflection.Assembly]::LoadWithPartialName( "System.Windows.Forms" )
	
	Write-Host “The Application is $exe”
	#open app 
	& $exe
	
	#find executable name
	$name = $exe.Split("\") 
	$name = $name.Get($name.Length-1)
	$name = $name.Split(".")
	$name = $name.Get(0)
	echo "name = $name"
	
	#wait program to open
	while((select-window -ProcessName $name) -eq $null)
	{
		echo "$name.exe still not open, waiting..."
		sleep 1
	}
	
	#find window title
	$title = (select-window -ProcessName $name)
	
	if($title.count -ge 2) #-is [System.Object[]])
	{
		$duplicates = $title[0].title
		echo "More than one window with '$duplicates', aborting..."
		return ;
	}
	$title = (select-window -ProcessName $name).Title
	echo "title = $title"
	
	#check if dir for $name already exists
	if(!(Test-Path "$savedir$name"))
	{
		echo "Directory non-existing, creating '$savedir$name'..."
		mkdir "$savedir$name"
	}
	
	#cycle to save screenshots
	while(1) {
		#if closed , stop timelapse
		if((get-process $name) -eq $null)
		{
			echo "Application '$title' closed, aborting..."
			return 
		}
		#if duplicated , stop timelapse
		if((get-process $name) -is "System.Object[]")
		{
			echo "Application '$title' duplicated, aborting..."
			return 
		}
		
		$now = get-date -uformat "$name_%Y-%m-%d__%Hh_%Mm_%Ss"
		$window = (select-window -ProcessName $name).GetPosition()
		
		#check if windows is minimized or not focused
		if(		$window.Location.X -le -5000 -or $window.Location.Y -le -5000 -or !(select-window -ProcessName $name).GetIsActive())
		{
			echo "Skipping screenshot, window is minimized or hidden..."
		}
		else 
		{
			#echo "D:\TimeLapses\$name\$now.jpeg"
			Export-Screenshot "$savedir$name\$now.jpeg" $window
		}
		sleep $waiting_time
	}
}