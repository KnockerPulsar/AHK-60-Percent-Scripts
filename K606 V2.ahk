#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
#InstallKeybdHook
#Persistent
#SingleInstance
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

CheckShift()
{
    return GetKeyState("Shift","P")? "+" : ""
    }

    CheckControl()
    {
    return GetKeyState("Control","P")? "^":"" 
    }

    CheckAlt()
    {
    return GetKeyState("Alt","P")? "!":""
    }

    CheckWin()
    {
        return GetKeyState("LWin", "P")? "#":""
    }
    CheckModifiers(WantedResult,baseKey="") {
        global DEBUG
        shift := CheckShift()
        ctrl := CheckControl()
        alt := CheckAlt()
        win := CheckWin() ; Left until I find a way to override win+key events, thanks Microsoft!
        if(!alt && !ctrl && !shift && !win && baseKey != "") {
            Send, {%baseKey%}
            return
        }
        Send, %shift%%ctrl%%alt%{%WantedResult%}
    Return
}

; KeyHistory

; + = Shift
; ! = Alt
; ^ = Ctrl
; SC035 = /? (The key left of RShift)
; SC029 = ` or ~ (Top left)

; Up, Down, Left Right
; Select one line (left/right) or one word (left/right) or one char (left/right)
;===============================================================================
CapsLock & K:: CheckModifiers("Up") return
CapsLock & J:: CheckModifiers("Down") return
CapsLock & L:: CheckModifiers("Right") return
CapsLock & H:: CheckModifiers("Left") return

; Lost functionality
;===============================================================================
; Ctrl + Alt + / = Ctrl + Alt + Delete
^!SC035::Send, ^!{Delete}

; Caps + ` = ` (Since ` is overridden to be ESC)
CapsLock & SC029:: Send, {SC029}

; Caps + Shift + [ = Shift + Home
CapsLock & [:: CheckModifiers("Home")

; Caps + Shift + ] = Shift + End
CapsLock & ]:: CheckModifiers("End")

CapsLock & `;::  CheckModifiers("PgUp")

; Caps + Shift + ' = Shift + Page Down
CapsLock & ':: CheckModifiers("PgDn")

; ` = Escape
SC029:: Send, {Escape}

; Ctrl + Shift + ` = Ctrl + Shift + Escape
^+SC029:: Send, ^+{Escape}

; Play/Pause Media
AppsKey:: Send,{Media_Play_Pause}

; Function keys
;===============================================================================

Capslock & 1:: CheckModifiers("F1")
CapsLock & 2:: CheckModifiers("F2")
CapsLock & 3:: CheckModifiers("F3")
CapsLock & 4:: CheckModifiers("F4")
CapsLock & 5:: CheckModifiers("F5")
CapsLock & 6:: CheckModifiers("F6")
CapsLock & 7:: CheckModifiers("F7")
CapsLock & 8:: CheckModifiers("F8")
CapsLock & 9:: CheckModifiers("F9")
CapsLock & 0:: CheckModifiers("F10")
CapsLock & -:: CheckModifiers("F11")
CapsLock & +:: CheckModifiers("F12")