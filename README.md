# AutoHotkey Hide Volume OSD

This is an AutoHotkey script you can use to hide (and restore) the Windows 8/10/11 volume osd (on-screen display).

That is, the volume level display that appears at the top left of your screen every time you adjust the volume. It covers up part of the screen for several seconds and many apps display large media summaries next to it covering even more of your screen, which can be very bothersome.

Windows provides no way of disabling it. Some apps allow you to at least disable their large media summaries, but it's not always simple (browsers require you to search for specific fields in their about:config tab, for example), and you still have the annoying volume display itself. Much easier if you could just completely turn it off.

Now you can!

# How to use it

1) Install [AutoHotkey](https://www.autohotkey.com/) version 1.x in order to run .ahk scripts. Not tested with AutoHotkey version 2.
2) Download [all files](https://github.com/sophice/ahk-hide-volume-osd/archive/refs/heads/main.zip) from this repo and extract/place them where you want.
3) Run hide-volume-osd.ahk to hide the volume osd.
4) Run show-volume-osd.ahk to restore the volume osd.

Note: This is not permanent, it will only apply until you reboot your system. Every time you reboot, you will have to run this again to hide the volume osd.

# Known issues

- Must be run every time you reboot, cannot permanently hide the volume osd.

# Potential future improvements

- Tray icon version, with menus to toggle the volume osd on/off.
- Ability to install itself to automatically run on startup.

# Credits

The method used by this script to hide and show the volume osd was discovered by [UnlimitedStack/HideVolumeOSD](https://github.com/UnlimitedStack/HideVolumeOSD).
