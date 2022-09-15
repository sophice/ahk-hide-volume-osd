# AutoHotkey Hide Volume OSD

This is an AutoHotkey script you can use to hide (and restore) the Windows volume OSD (on-screen display).

Whenever you adjust the volume in Windows, a volume level display appears at the top left, sometimes with a large media summary of a video you are watching. This covers up a portion of the screen for several seconds and can be really bothersome while working.

Windows provides no way of disabling it. Some apps allow you to disable their large media summaries, but it's not always simple (browsers require you to search for obscure settings in their about:config tab, for example), and you still have the annoying volume display itself.

Not any more!

# How to use it

1) Install [AutoHotkey](https://www.autohotkey.com/) version 1.x in order to run .ahk scripts. Not tested with AutoHotkey version 2.
2) Download [all files](https://github.com/sophice/ahk-hide-volume-osd/archive/refs/heads/main.zip) from this repo and extract/place them where you want.

From here, there are three ways to run this script.

1) Run `hide-volume-osd.ahk` and `show-volume-osd.ahk` to hide and show the volume OSD. Use this to manually turn it on/off when you want, or just to test things out. The volume OSD will only remain hidden until you restart Windows again, so you will have to run `hide-volume-osd.ahk` after every restart.
2) Run `install.ahk` to have Windows automatically run `hide-volume-osd.ahk` after every restart, so it's always hidden. Run `uninstall.ahk` to undo this.
3) **Advanced users**: Run `hide-by-window.ahk` to only show or only hide the volume OSD in certain windows. You can edit the script and modify the `hideByDefault` and `exeNames` variables to control this behavior.

# Credits

The technique used by this script to find and toggle the volume OSD was discovered by [UnlimitedStack/HideVolumeOSD](https://github.com/UnlimitedStack/HideVolumeOSD).
