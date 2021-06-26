#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#InstallKeybdHook
#Persistent
#SingleInstance
; KeyHistory

; ALT + 4 = ALT + F4
!4:: Send, !{F4} 
return

; ALT + A = ARROW LEFT
!A:: Send, {Left} 
return

; ALT + D = ARROW RIGHT
!D:: Send, {Right} 
return

; ALT + W = ARROW UP 
!W:: Send, {Up} 
return

; ALT + S = ARROW DOWN
!S:: Send, {Down} 
return

; CTRL + ALT + A = CTRL + ARROW LEFT
^!A:: Send, ^{Left} 
return

; CTRL + ALT + D = CTRL + ARROW RIGHT
^!D:: Send, ^{Right} 
return

; SHIFT + ALT + = SHIFT + UP (SELECT UP)
+!W:: Send, +{Up} 
return

; SHIFT + ALT + S = SHIFT + DOWN (SELECT DOWN) 
+!S:: Send, +{Down} 
return

; SHIFT + ALT + A = SHIFT + LEFT (SELECT 1 CHAR LEFT)
+!A:: Send, +{Left} 
return

; SHIFT + ALT + D = SHIFT + RIGHT (SELECT 1 CHAR RIGHT)
+!D:: Send, +{Right} 
return

SC029:: Send {Escape} 
return

; ALT + ` = ESCAPE
!SC029:: Send, {sc029} 
return


; CTRL+ALT+/ = CTRL + ALT + DELETE (WINDOWS MENU)
^!SC035:: send, ^!{delete} 
return

; CTRL + SHIFT + ` = CTRL + SHIFT + ESCAPE (OPEN TASK MANAGER)
^+`:: Send, ^+{Escape} 
return

; ALT + \ = Play/Pause
#If !GetKeyState("CapsLock", "T")
\:: Send, {Media_Play_Pause} 
return