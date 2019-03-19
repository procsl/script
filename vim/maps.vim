" {{{ 快速编辑
" 快速编辑vim配置文件
nnoremap <leader>vv :split $VIM/_vimrc<CR>
" 快速编辑vim属性配置文件
nnoremap <leader>vu :split $VIM/user.vim<CR>
" 快速编辑插件配置文件
nnoremap <leader>vp :split $VIM/plug.vim<CR>
" 快速编辑gvim
nnoremap <leader>vg :split $VIM/_gvimrc<CR>
" 映射配置文件
nnoremap <leader>vms :split $VIM/maps.vim<CR>
" gui模式映射
nnoremap <leader>vmg :split $VIM/gmaps.vim<CR>
" }}}
"
"{{{ ycm 的按键映射
noremap <Leader>gl :YcmCompleter GoToDeclaration<CR>
noremap <Leader>gf :YcmCompleter GoToDefinition<CR>
noremap <Leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
noremap <Leader>gr :YcmCompleter GoToReferences<CR>
noremap <Leader>go :YcmCompleter GoTo<CR>

noremap <Leader>gt :YcmCompleter GetType<CR>
noremap <Leader>gd :YcmCompleter GetDoc<CR>

noremap <Leader>fi :YcmCompleter FixIt<CR>
noremap <Leader>ft :YcmCompleter Format<CR>

noremap <Leader>rm :YcmCompleter RefactorRename 
" }}}
