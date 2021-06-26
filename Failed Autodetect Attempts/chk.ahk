#persistent
#singleinstance

iCount := HID_GetDevCount()
NamesToCheck := Array()

;My Redragon Keyboard "0003#{884b96c3-56ef-11d1-bc8c-00a0c91405dd}"
NamesToCheck.Push("0003#{884b96c3-56ef-11d1-bc8c-00a0c91405dd}")
Loop , %icount% 
{
    HID0 += 1
    HID%HID0%_Name := HID_GetDevName(HID0)
    HID%HID0%_Type := HID_GetDevType(HID0)

    name := HID_GetDevName(HID0)
    type :=	HID_GetDevType(HID0)
    ; if type = 1	; RIM_TYPEKEYBOARD = 1 means the device is a keyboard.
    ; {
    if HasVal(NamesToCheck,HID%HID0%_Name)
    {
        if name contains HID 
        {
            ;outputdebug (%icount% : %HID0%) function_check_usb`n%HID0%`n%type% - %name%
            OutputDebug "Connected"
            break
        }
    }
    else
    {
        OutputDebug "Disconnected"
        ;outputdebug (%icount% : %HID0%) Keyboard not found
    }
    ; }
}

exitapp

HID_Initialize(bRefresh = False) {
    Static uHIDList, bInitialized := False

    If bInitialized And Not bRefresh
        Return &uHIDList

    ;Get the device count
    r := DllCall("GetRawInputDeviceList", "UInt", 0, "UInt*", iCount, "UInt", 8)
    ;Check for error
    If (r = -1) Or ErrorLevel {
        ErrorLevel = GetRawInputDeviceList call failed.`nReturn value: %r%`nErrorLevel: %ErrorLevel%`nLine: %A_LineNumber%`nLast Error: %A_LastError%
        outputdebug (%A_LineNumber%) %Errorlevel%
        Return -1
    }

    ;Prep var
    VarSetCapacity(uHIDList, iCount * 8)
    r := DllCall("GetRawInputDeviceList", "UInt", &uHIDList, "UInt*", iCount, "UInt", 8)
    If (r = -1) Or ErrorLevel {
        ErrorLevel = GetRawInputDeviceList call failed.`nReturn value: %r%`nErrorLevel: %ErrorLevel%`nLine: %A_LineNumber%`nLast Error: %A_LastError%
        outputdebug (%A_LineNumber%) %Errorlevel%
        Return -1
    }

    bInitialized := True
    Return &uHIDList
}

HID_GetDevHandle(i) {
    Return NumGet(HID_Initialize(), (i - 1) * 8)
}

HID_GetDevName(i, IsHandle = False) {
    RIDI_DEVICENAME := 0x20000007

    ;Get index if i is handle
    h := IsHandle ? i : HID_GetDevHandle(i)

    ;Get device name length
    r := DllCall("GetRawInputDeviceInfo", "UInt", h, "UInt", RIDI_DEVICENAME, "UInt", 0, "UInt*", iLength)
    If (r = -1) Or ErrorLevel {
        ErrorLevel = GetRawInputDeviceInfo call failed.`nReturn value: %r%`nErrorLevel: %ErrorLevel%`nLine: %A_LineNumber%`nLast Error: %A_LastError%
        ;outputdebug (%A_LineNumber%) %errorlevel%
        Return ""
    }

    ;Get device name
    VarSetCapacity(s, iLength + 1)
    r := DllCall("GetRawInputDeviceInfo", "UInt", h, "UInt", RIDI_DEVICENAME, "Str", s, "UInt*", iLength)
    If (r = -1) Or ErrorLevel {
        ErrorLevel = GetRawInputDeviceInfo call failed.`nReturn value: %r%`nErrorLevel: %ErrorLevel%`nLine: %A_LineNumber%`nLast Error: %A_LastError%
        ;outputdebug (%A_LineNumber%) %errorlevel%
        Return ""
    }

    Return s
}

HID_GetDevType(i, IsHandle = False) {
    Return Not IsHandle ? NumGet(HID_Initialize(), ((i - 1) * 8) + 4)
    : NumGet(HID_Initialize(), ((HID_GetDevIndex(i) - 1) * 8) + 4)
}

HID_GetDevCount() {
    ;Get the device count
    r := DllCall("GetRawInputDeviceList", "UInt", 0, "UInt*", iCount, "UInt", 8)
    ;Check for error
    If (r = -1) Or ErrorLevel {
        ErrorLevel = GetRawInputDeviceList call failed.`nReturn value: %r%`nErrorLevel: %ErrorLevel%`nLine: %A_LineNumber%`nLast Error: %A_LastError%
        ; outputdebug (%A_LineNumber%) %errorlevel%
        Return -1
    } Else Return iCount
}

HID_GetDevIndex(Handle) {
    Loop % HID_GetDevCount()
        If (NumGet(HID_Initialize(), (A_Index - 1) * 8) = Handle)
        Return A_Index
    Return 0
}

HasVal(haystack, needle) {
    for index, value in haystack
        if (value = needle)
        return index
    if !(IsObject(haystack))
        throw Exception("Bad haystack!", -1, haystack)
    return 0
}