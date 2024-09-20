" A very simple script to switch Mac IM in Vim. 
" Aiming to use US/ABC for normal
" mode and restore the prevoius IM when coming back to the INSERT mode.
" - only supports two IMs
" - define `<Cmd - Space>` as the shortcut for switch IM in Mac system
"   setting
" - `s:toggleIM` defines the awkard shell command to switch IM by simulating
"   keypress through applescript

if exists("g:autoloaded_toggleMacIM")
  finish
endif
let g:autoloaded_toggleMacIM = 1


let s:chkCmd = "defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources|grep 'KeyboardLayout Name'"
let s:toggleIM = 'echo "tell application \"System Events\" to key code 49 using {command down}" | osascript'

call system(s:chkCmd)
let s:pre_is_cn = v:shell_error


function! toggleMacIM#checkCurrentIM() 
  call system(s:chkCmd)
  let s:pre_is_cn = v:shell_error
endfunction

"INSERT -> NORMAL
function! toggleMacIM#leaveInsert()
  call toggleMacIM#checkCurrentIM()
  if(s:pre_is_cn)
    call system(s:toggleIM)
  endif
endfunction

" NORMAL -> INSERT
function! toggleMacIM#enterInsert()
  if(s:pre_is_cn)
    call system(s:toggleIM)
  endif
endfunction

augroup mac_im_handling
  autocmd!
  autocmd InsertLeave * call toggleMacIM#leaveInsert()
  autocmd InsertEnter * call toggleMacIM#enterInsert()
augroup END

" vim: ts=2:sw=2:tw=78:fdm=marker:expandtab
