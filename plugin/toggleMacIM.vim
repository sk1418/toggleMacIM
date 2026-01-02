" A very simple script to switch Mac IM in Vim. 
" Aiming to use US/ABC for normal
" mode and restore the prevoius IM when coming back to the INSERT mode.
" - only supports two IMs
" - requires im-select
" - define g:im_for_normal_mode for IM in the normal mode. Default: 'com.apple.keylayout.ABC'
" - define g:im_non_abc for the non-english IM, the default is: 'com.sogou.inputmethod.sogou.pinyin'
"
if exists("g:autoloaded_toggleMacIM")
  finish
endif
let g:autoloaded_toggleMacIM = 1

let g:im_for_normal_mode = exists('g:im_for_normal_mode')? g:im_for_normal_mode : 'com.apple.keylayout.ABC'
let g:im_non_abc = exists('g:im_non_abc')? g:im_non_abc : 'com.sogou.inputmethod.sogou.pinyin'

let s:chkCmd = "im-select"

function! toggleMacIM#checkCurrentIM() 
  let s:pre_is_cn = g:im_for_normal_mode != trim(system(s:chkCmd))
endfunction

call toggleMacIM#checkCurrentIM()

function! toggleMacIM#toggleIM(im_required) 
  let s:toggleIM = 'im-select ' . a:im_required
  call system(s:toggleIM)
endfunction

"INSERT -> NORMAL
function! toggleMacIM#leaveInsert()
  call toggleMacIM#checkCurrentIM()
  if(s:pre_is_cn)
    call toggleMacIM#toggleIM(g:im_for_normal_mode)
  endif
endfunction

" NORMAL -> INSERT
function! toggleMacIM#enterInsert()
  if(s:pre_is_cn)
    call toggleMacIM#toggleIM(g:im_non_abc)
  endif
endfunction

augroup mac_im_handling
  autocmd!
  autocmd InsertLeave * call toggleMacIM#leaveInsert()
  autocmd InsertEnter * call toggleMacIM#enterInsert()
augroup END

" vim: ts=2:sw=2:tw=78:fdm=marker:expandtab
