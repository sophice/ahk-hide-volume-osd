;this script must be run as administrator. if not, restart, requesting administrator access
if(!A_IsAdmin)
{
    Run *RunAs "%A_ScriptFullPath%"
    ExitApp
}

;delete the scheduled task
RunWait, %A_WinDir%\System32\schtasks.exe /Delete /TN "Hide Volume OSD" /F

;show the volume OSD right away, since that's obviously what the user wants
#include %A_ScriptDir%\VolumeOsd.ahk
VolumeOsd.Show()