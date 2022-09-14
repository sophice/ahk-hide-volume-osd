if(!A_IsAdmin)
{
    Run *RunAs "%A_ScriptFullPath%"
    ExitApp
}

RunWait, %A_WinDir%\System32\schtasks.exe /Delete /TN "Hide Volume OSD" /F