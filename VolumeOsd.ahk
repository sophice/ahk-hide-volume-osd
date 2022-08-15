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
        result := 0
        count := 0
        parentHandle := 0

        loop
        {
            parentHandle := DllCall("FindWindowEx", "uint", 0, "uint", parentHandle, "str", "NativeHWNDHost", "uint", 0)

            ;if there are no windows found, stop the loop
            if(parentHandle = 0)
            {
                break
            }

            childHandle := DllCall("FindWindowEx", "uint", parentHandle, "uint", 0, "str", "DirectUIHWND", "uint", 0)

            ;if the child window isn't there, this definitely isn't the volume osd, skip to the next loop
            if(childHandle = 0)
            {
                continue
            }

            count++

            ;if we found more than one match, we can't be sure which one is the one, so we fail
            if(count > 1)
            {
                return 0
            }

            ;we found a match! store it to be returned later
            result := parentHandle
        }

        ;we found a match, and only one, return it!
        return result
    }
}