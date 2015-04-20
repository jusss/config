;左capslock键按住释放就是esc,按住再按别的键释放，就是ctrl,左ctrl是capslock,右ctrl是鼠标中键
;修改完script后从右下角右击autohotkey这个图标然后reload this script即可生效
; IMPORTANT INFO ABOUT GETTING STARTED: Lines that start with a
; semicolon, such as this one, are comments.  They are not executed.

; This script has a special filename and path because it is automatically
; launched when you run the program directly.  Also, any text file whose
; name ends in .ahk is associated with the program, which means that it
; can be launched simply by double-clicking it.  You can have as many .ahk
; files as you want, located in any folder.  You can also run more than
; one ahk file simultaneously and each will get its own tray icon.

; SAMPLE HOTKEYS: Below are two sample hotkeys.  The first is Win+Z and it
; launches a web site in the default browser.  The second is Control+Alt+N
; and it launches a new Notepad window (or activates an existing one).  To
; try out these hotkeys, run AutoHotkey again, which will load this file.

#z::Run www.autohotkey.com

^!n::
IfWinExist Untitled - Notepad
	WinActivate
else
	Run Notepad
return


; Note: From now on whenever you run AutoHotkey directly, this script
; will be loaded.  So feel free to customize it to suit your needs.

; Please read the QUICK-START TUTORIAL near the top of the help file.
; It explains how to perform common automation tasks such as sending
; keystrokes and mouse clicks.  It also explains more about hotkeys.


g_LastCtrlKeyDownTime := 0
g_AbortSendEsc := false
g_ControlRepeatDetected := false
 
*CapsLock::
if (g_ControlRepeatDetected)
{
return
}
 
send,{Ctrl down}
g_LastCtrlKeyDownTime := A_TickCount
g_AbortSendEsc := false
g_ControlRepeatDetected := true
 
return
 
*CapsLock Up::
send,{Ctrl up}
g_ControlRepeatDetected := false
if (g_AbortSendEsc)
{
return
}
current_time := A_TickCount
time_elapsed := current_time - g_LastCtrlKeyDownTime
if (time_elapsed <= 250)
{
SendInput {Esc}
}
return
 
~*^a::
g_AbortSendEsc := true
return
~*^b::
g_AbortSendEsc := true
return
~*^c::
g_AbortSendEsc := true
return
~*^d::
g_AbortSendEsc := true
return
~*^e::
g_AbortSendEsc := true
return
~*^f::
g_AbortSendEsc := true
return
~*^g::
g_AbortSendEsc := true
return
~*^h::
g_AbortSendEsc := true
return
~*^i::
g_AbortSendEsc := true
return
~*^j::
g_AbortSendEsc := true
return
~*^k::
g_AbortSendEsc := true
return
~*^l::
g_AbortSendEsc := true
return
~*^m::
g_AbortSendEsc := true
return
~*^n::
g_AbortSendEsc := true
return
~*^o::
g_AbortSendEsc := true
return
~*^p::
g_AbortSendEsc := true
return
~*^q::
g_AbortSendEsc := true
return
~*^r::
g_AbortSendEsc := true
return
~*^s::
g_AbortSendEsc := true
return
~*^t::
g_AbortSendEsc := true
return
~*^u::
g_AbortSendEsc := true
return
~*^v::
g_AbortSendEsc := true
return
~*^w::
g_AbortSendEsc := true
return
~*^x::
g_AbortSendEsc := true
return
~*^y::
g_AbortSendEsc := true
return
~*^z::
g_AbortSendEsc := true
return

LControl::CapsLock

RControl::mouseclick, middle
