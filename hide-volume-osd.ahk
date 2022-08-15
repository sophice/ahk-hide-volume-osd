#include %A_ScriptDir%\VolumeOsd.ahk

if(!VolumeOsd.Exists())
{
    MsgBox, "Error: Could not find volume OSD"
} else {
    VolumeOsd.Hide()
}