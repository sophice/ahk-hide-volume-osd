class VolumeOsd
{
    Exists()
    {
        return this.Find() != 0
    }

    Hide()
    {
        handle := this.Find()
        if(handle != 0)
        {
            DllCall("ShowWindow", "UInt", handle, "Int", "6")
        }
    }

    Show()
    {
        handle := this.Find()
        if(handle != 0)
        {
            DllCall("ShowWindow", "UInt", handle, "Int", "9")
        }
    }

    Find()
    {
        ;the handle for the volume OSD window, if we found it
        result := 0

        ;used to iterate through matching windows until we find the right ones, and for finding child windows
        parentHandle := 0

        ;whether or not we've tried adjusting the volume to force the volume OSD window to appear
        volumeTried := false

        ;we'll come back here and run the loop again after a second attempt to reveal the volume OSD window
        Loop:

        loop
        {
            ;find the parent window (hopefully the Volume OSD window)
            parentHandle := DllCall("FindWindowEx", "uint", 0, "uint", parentHandle, "str", "NativeHWNDHost", "uint", 0)

            ;if there are no more matching windows, stop the loop
            if(parentHandle = 0)
            {
                break
            }

            ;verify if the parent window has a matching child (this is how we know it's the right window)
            childHandle := DllCall("FindWindowEx", "uint", parentHandle, "uint", 0, "str", "DirectUIHWND", "uint", 0)

            ;if the child window isn't there, this definitely isn't the volume osd, skip to the next loop
            if(childHandle = 0)
            {
                continue
            }

            ;if we previously found a match and now another, we can't be sure which one is the right one, so we fail
            if(result != 0)
            {
                return 0
            }

            ;we found a match! store it to be checked and returned later
            result := parentHandle
        }

        ;if we didn't find the window (especially during startup), triggering a volume change can force it out
        if(result = 0 && !volumeTried)
        {
            Send, {Volume_Up}
            Send, {Volume_Down}
            volumeTried := true
            Goto, Loop
        }

        return result
    }
}
