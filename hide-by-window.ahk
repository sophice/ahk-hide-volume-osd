;false = only hide volume OSD in windows matching exeNames, true = only show volume OSD in those windows
hideByDefault := false

;list of window process exes to match against
exeNames := ["phpstorm64.exe"]

#include %A_ScriptDir%\VolumeOsd.ahk

Gui +LastFound
DllCall("RegisterShellHookWindow", UInt, WinExist())
MsgNum := DllCall("RegisterWindowMessage", Str, "SHELLHOOK")
OnMessage(MsgNum, "ShellMessage")

;if we want it hidden by default, hide it immediately
if(hideByDefault)
{
    VolumeOsd.Hide()
}

ShellMessage(wParam, lParam)
{
    global hideByDefault
    global exeNames

    ;check for HSHELL_WINDOWACTIVATED or HSHELL_RUDEAPPACTIVATED
    if(wParam = 4 or wParam = 32772)
    {
        WinGetTitle, title, ahk_id %lParam%
        WinGet, name, ProcessName, A
        WinGet, path, ProcessPath, A

        ;MsgBox % title . " = " . name . " = " . path
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