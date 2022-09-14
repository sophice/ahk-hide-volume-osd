class VolumeOsd
{
    Hide()
    {
        handle := this.Find()

        if(handle = 0)
        {
            return false
        }

        DllCall("ShowWindow", "UInt", handle, "Int", "6")
        return true
    }

    Show()
    {
        handle := this.Find()

        if(handle = 0)
        {
            return false
        }

        DllCall("ShowWindow", "UInt", handle, "Int", "9")
        return true
    }

    Find()
    {
        ;the handle for the volume OSD window, if we find it
        result := 0

        loop 10
        {
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
            if(result = 0)
            {
                ;but first, we'll wait a while to try again, waiting longer each time
                Sleep, 1000 * (A_Index ** 2)
                Send, {Volume_Up}
                Send, {Volume_Down}
            } else {
                break
            }
        }

        return result
    }
}
