# AutoHotkey Hide Volume OSD

This is an AutoHotkey script you can use to hide (and restore) the Windows volume OSD (on-screen display).

Whenever you adjust the volume in Windows, a volume level display appears at the top left, sometimes with a large media summary of a video you are watching. This covers up a portion of the screen for several seconds and can be really bothersome while working.

Windows provides no way of disabling it. Some apps allow you to disable their large media summaries, but it's not always simple (browsers require you to search for obscure settings in their about:config tab, for example), and you still have the annoying volume display itself.

Not any more!

# How to use it

1) Install [AutoHotkey](https://www.autohotkey.com/) version 1.x in order to run .ahk scripts. Not tested with AutoHotkey version 2.
2) Download [all files](https://github.com/sophice/ahk-hide-volume-osd/archive/refs/heads/main.zip) from this repo and extract/place them where you want.
3) Run hide-volume-osd.ahk to hide the volume OSD.
4) Run show-volume-osd.ahk to restore the volume OSD.
5) Optionally, run install.ahk to "permanently" hide the volume OSD.

Running install.ahk creates a scheduled task to run hide-volume-osd.ahk every time you log in to Windows. If you change your mind later, just run uninstall.ahk to delete the scheduled task.

# Credits

The technique used by this script to find and toggle the volume osd was discovered by [UnlimitedStack/HideVolumeOSD](https://github.com/UnlimitedStack/HideVolumeOSD).
