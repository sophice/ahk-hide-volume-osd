;this script must be run as administrator. if not, restart, requesting administrator access
if(!A_IsAdmin)
{
    Run *RunAs "%A_ScriptFullPath%"
    ExitApp
}

;get the path to autohotkey
RegRead, ahkpath, HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\AutoHotkey.exe

;create a scheduled task to run on startup
RunWait, %A_WinDir%\System32\schtasks.exe /Create /SC ONLOGON /RL HIGHEST /TN "Hide Volume OSD" /F /TR "'%ahkpath%' %A_ScriptDir%\hide-volume-osd.ahk"

;hide the volume OSD right away, since that's obviously what the user wants
#include %A_ScriptDir%\VolumeOsd.ahk
VolumeOsd.Hide()