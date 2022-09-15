;false = only hide volume OSD in windows matching exeNames, true = only show volume OSD in those windows
hideByDefault := false

;list of window process exes to match against
exeNames := ["phpstorm64.exe"]

#include %A_ScriptDir%\VolumeOsd.ahk

;create a shell hook to track whenever the active window changes
Gui +LastFound
DllCall("RegisterShellHookWindow", UInt, WinExist())
MsgNum := DllCall("RegisterWindowMessage", Str, "SHELLHOOK")
OnMessage(MsgNum, "ShellMessage")

;immediately show or hide the volume OSD based on the user's choice
if(hideByDefault)
{
    VolumeOsd.Hide()
} else {
    VolumeOsd.Show()
}

ShellMessage(wParam, lParam)
{
    global hideByDefault
    global exeNames

    ;check for HSHELL_WINDOWACTIVATED (4) or HSHELL_RUDEAPPACTIVATED (32772, used when there is a full screen window)
    if(wParam = 4 or wParam = 32772)
    {
        ;get the executable filename of the active window
        WinGet, name, ProcessName, A

        ;get the executable path and filename of the active window
        ;WinGet, path, ProcessPath, A

        ;get the title of the active window
        ;WinGetTitle, title, ahk_id %lParam%

        ;check whether or not the active Window's executable filename is in the match list
        if(InArray(exeNames, name))
        {
            if(hideByDefault)
            {
                VolumeOsd.Show()
            } else {
                VolumeOsd.Hide()
            }
        } else {
            if(hideByDefault)
            {
                VolumeOsd.Hide()
            } else {
                VolumeOsd.Show()
            }
        }
    }
}

InArray(haystack, needle)
{
    if(!IsObject(haystack) || haystack.Length() = 0)
    {
        return false
    }

    for index, value in haystack
    {
        if (value = needle)
        {
            return true
        }
    }

    return false
}