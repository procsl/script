#NoEnv
#WinActivateForce
#SingleInstance, Force
#include IME.ahk
SetCapsLockState AlwaysOff
; #NoTrayIcon ; 状态栏图标, 按需注释
ListLines, Off
SendMode Input
SetBatchLines -1
SetControlDelay 0
SetWorkingDir %A_ScriptDir%

; 置换默认的左ctrl-space行为，让其不触发输入法切换，为ide补全留出来
<^Space::ControlSend, ,{LCtrl Up}{LCtrl Down}{Space Down}{Space Up}{LCtrl Up}, A

; ESC直接切换到英文，类VIM应用有用

 ~Esc::CIM_SendKey()

; ^[::CIM_SendKey()

; ^c::CIM_SendKey_Ctrl_C()


Capslock::Send_ESC()

; #space::Run "D:\Program Files\Terminal\open-wsl.exe" -l 

CIM_SendKey()
{
	; ConvESC()
	IME_SET(0)
	Send {Esc}
}


CIM_SendKey_Ctrl_C()
{
	; ConvESC()
	IME_SET(0)
	SendInput {Raw}
}

ConvESC() {
  if (GetIME() = 1) {
    Send {RCtrl Down}{Space Down}{Space Up}{RCtrl Up}
  }
}


Send_ESC(){
	SetCapsLockState AlwaysOff
	CIM_SendKey()
}

GetIME(WinTitle="") {
	ifEqual WinTitle,,  SetEnv,WinTitle,A
	WinGet,hWnd,ID,%WinTitle%
	DefaultIMEWnd := DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hWnd, Uint)
	DetectSave := A_DetectHiddenWindows
	DetectHiddenWindows,ON
	SendMessage 0x283, 0x005,0,,ahk_id %DefaultIMEWnd%
	DetectHiddenWindows,%DetectSave%
	Return ErrorLevel
}


; 打开或者切换程序
; Function to run a program or activate an already running instance 
RunOrActivateProgram(Program, WorkingDir="", WindowSize=""){ 
    SplitPath Program, ExeFile 
    Process, Exist, %ExeFile% 
    PID = %ErrorLevel% 
    if (PID = 0) { 
		Run, %Program%, %WorkingDir%, %WindowSize% 
    }else{ 
		WinActivate, ahk_pid %PID% 
    } 
}


Capslock & j::
SetCapsLockState AlwaysOff
RunOrActivateProgram("chrome.exe")
return

Capslock & i::
SetCapsLockState AlwaysOff
RunOrActivateProgram("idea64.exe")
return

Capslock & n::
SetCapsLockState AlwaysOff
RunOrActivateProgram("notepad++.exe")
return

Capslock & f::
SetCapsLockState AlwaysOff
RunOrActivateProgram("firefox.exe")
return

Capslock & s::
SetCapsLockState AlwaysOff
Run "C:\Users\procsl\script\Vim.ahk"
return



Ctrl & [::
CIM_SendKey()
return

SwitchIME(dwLayout){
    HKL:=DllCall("LoadKeyboardLayout", Str, dwLayout, UInt, 1)
    ControlGetFocus,ctl,A
    SendMessage,0x50,0,HKL,%ctl%,A
}


; F12::
;   WinGetActiveTitle, Title
;   MsgBox, The active window is "%Title%".
; return

