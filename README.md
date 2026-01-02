# Introduction

A very simple script to switch Mac IM in Vim, aiming to use US/ABC for normal
 mode and restore the prevoius IM when coming back to the INSERT mode:

 - only supports two IMs
 - requires [im-select](https://github.com/daipeihust/im-select)
 - define `g:im_for_normal_mode` for IM in the normal mode. Default: `com.apple.keylayout.ABC`
 - define `g:im_non_abc` for the non-english IM, the default is: `com.sogou.inputmethod.sogou.pinyin`

