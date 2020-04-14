#NoEnv
#WinActivateForce
#SingleInstance, Force
#NoTrayIcon ; 状态栏图标, 按需注释
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

; ^c::CIM_SendKey_Ctrl_C()

Capslock::Send {ESC}

#space::Run "C:\Users\procsl\wsl-terminal\wsl-terminal\open-wsl.exe" -l 

CIM_SendKey()
{
	ConvESC()
	Send {Esc}
}

CIM_SendKey_Ctrl_C()
{
	ConvESC()
	SendInput {Raw}
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
RunOrActivateProgram("chrome.exe")
return

Capslock & i::
RunOrActivateProgram("idea64.exe")
return

Capslock & n::
RunOrActivateProgram("notepad++.exe")
return 