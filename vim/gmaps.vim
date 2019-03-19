" {{{"映射 Alt+Enter 切换全屏vim
nnoremap <Leader>fu <ESC>:call ToggleFullScreen()<CR>
"切换Vim是否在最前面显示
nnoremap <F10> <ESC>:call SwitchVimTopMostMode()<CR>
"增加Vim窗体的不透明度
nnoremap <F12> <esc>:call SetAlpha(10)<CR>
"增加Vim窗体的透明度
nnoremap <F11> <ESC>:call SetAlpha(-10)<CR>
" 默认设置透明
" }}}
