# Introduction

A very simple script to switch Mac IM in Vim, aiming to use US/ABC for normal
 mode and restore the prevoius IM when coming back to the INSERT mode:

 - only supports two IMs
 - define `<Cmd - Space>` as the shortcut for switch IM in Mac system
   setting
 - `s:toggleIM` defines the awkard shell command to switch IM by simulating
   keypress through applescript
