#NoEnv
#SingleInstance, Force
#Persistent
#MaxThreadsPerHotkey, 1
#Include CaptureScreen.ahk
Process, Priority,, High
SetBatchLines, -1
SendMode Input
SetWorkingDir %A_ScriptDir%


if (A_IsAdmin = 0)
{
	try
	{
		if (A_IsCompiled)
		{
			Run *RunAs "%A_ScriptFullPath%" /restart
		}
		else
		{
			Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
		}
	}
	ExitApp
}

SCREENSHOT_COUNT := 2

Home::
{
	SoundBeep, 750, 500
	CaptureScreen(1, 0, SCREENSHOT_COUNT "-" A_Now ".png")
	SCREENSHOT_COUNT := SCREENSHOT_COUNT + 1
}
return

*F3::Reload

