#NoEnv
#WinActivateForce
#SingleInstance, Force
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

^[::CIM_SendKey()

#space::Run "D:\Program Files\Terminal\open-wsl.exe" -l -B "-w full"

CIM_SendKey()
{
	ConvESC()
	Send {Esc}
}

ConvESC() {
  if (GetIME() = 1) {
    Send {RCtrl Down}{Space Down}{Space Up}{RCtrl Up}
  }
}

CtrlI() {
  send ^{Insert} ; 插入个ctr-insert可以有效的避免某些场景需两次才能切出中文的问题，实测
  Send {LCtrl Up}{RCtrl Down}{Space Down}{Space Up}{RCtrl Up}
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