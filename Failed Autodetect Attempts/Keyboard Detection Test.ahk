#SingleInstance
#Persistent
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Recommended for catching common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
 
DriveGet, Devices2, List, REMOVABLE
SetTimer, DriveGet, 500
Return
 
DriveGet:
	DriveGet, Devices, List, REMOVABLE
	If (StrLen(Devices) < StrLen(Devices2))
	{
		Loop, parse, Devices2
		{
			If !InStr(Devices, A_LoopField)
			{
				DriveGet, Name, Label, %A_LoopField%:
				MsgBox, "Bye"
				TrayTip, Info, %A_LoopField%: (%Name%) has been disconnected., 30, 2
			}
		}
	}
	If (StrLen(Devices2) < StrLen(Devices))
	{
		Loop, parse, Devices
		{
			If !InStr(Devices2, A_LoopField)
			{
				DriveGet, Name, Label, %A_LoopField%:
				MsgBox, "Hi"
				TrayTip, Info, %A_LoopField%: (%Name%) has been connected., 30, 2
			}
		}
	}
	Devices2 := Devices