#SingleInstance
; MsgBox %val%

; runwait chk.ahk ; -- just in case the keyboard is connected when the script is started
OnMessage(0x219, "notify_change") 
return 

notify_change(wParam, lParam, msg, hwnd) 
{
    ;outputdebug notify_change(%wParam%, %lParam%, %msg%, %hwnd%) 
    if msg = 537
    {
        ; val := val + 1
        ; MsgBox %wParam% %msg%
		run chk.ahk
    }
}
