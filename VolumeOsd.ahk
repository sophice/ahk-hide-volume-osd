class VolumeOsd
{
    Exists()
    {
        return this.Handle() != 0
    }

    IsHidden()
    {
        if(!this.Exists())
        {
            return false
        }

        ;get the window's ShowWindow setting
        VarSetCapacity(wp, 44)
        NumPut(44, wp)
        DllCall("GetWindowPlacement", "UInt", this.Handle(), "UInt", &wp)
        state := NumGet(WP, 8, "UInt")

        ;2 = SW_SHOWMINIMIZED, we're checking if it's minimized or not
        return state = 2
    }

    Hide()
    {
        if(!this.Exists())
        {
            return false
        }

        if(this.IsHidden())
        {
            return true
        }

        ;6 = SW_MINIMIZE, we're minimizing the volume OSD window
        DllCall("ShowWindow", "UInt", this.Handle(), "Int", 6)
        return true
    }

    Show()
    {
        if(!this.Exists())
        {
            return false
        }

        if(!this.IsHidden())
        {
            return true
        }

        ;9 = SW_RESTORE, we're un-minimizing it
        DllCall("ShowWindow", "UInt", this.Handle(), "Int", 9)

        ;0 = SW_HIDE, this immediately "hides" it, because otherwise it will be displayed but invisible, blocking
        ;   clicks. we restore it, then hide it, so it won't interfere with the mouse, but next time the volume is
        ;   adjusted it will reappear like normal. there may be a better solution here, but this works ok.
        DllCall("ShowWindow", "UInt", this.Handle(), "Int", 0)

        return true
    }

    Handle()
    {
        ;the handle for the volume OSD window, if we find it
        static result := 0

        ;we previously did the searching already, so just return the handle we found
        if(result != 0)
        {
            return result
        }

        ;we will try 10 times, with increasing sleep delays between each attempt, to give the volume OSD time to be
        ;   created during logon
        loop 10
        {
            loop
            {
                ;find the parent window (hopefully the volume OSD window)
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
                ;we found the window! stop looping
                break
            }
        }

        return result
    }
}
