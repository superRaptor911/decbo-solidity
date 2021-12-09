let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/program/dapps/truffleTest
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +44 contracts/Voting.sol
badd +11 contracts/SimpleStorage.sol
badd +7 migrations/2_deploy_contracts.js
badd +29 contracts/UserContract.sol
badd +3 contracts/Rooms.sol
badd +51 test/Users.js
badd +27 test/Rooms.js
badd +1 lib/util.sol
argglobal
%argdel
edit contracts/Rooms.sol
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe '2resize ' . ((&lines * 2 + 22) / 45)
exe 'vert 2resize ' . ((&columns * 1 + 80) / 160)
exe '3resize ' . ((&lines * 2 + 22) / 45)
exe 'vert 3resize ' . ((&columns * 79 + 80) / 160)
argglobal
balt lib/util.sol
let s:l = 3 - ((2 * winheight(0) + 21) / 43)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 3
normal! 023|
wincmd w
argglobal
enew
balt contracts/Rooms.sol
wincmd w
argglobal
enew
balt contracts/Rooms.sol
wincmd w
exe '2resize ' . ((&lines * 2 + 22) / 45)
exe 'vert 2resize ' . ((&columns * 1 + 80) / 160)
exe '3resize ' . ((&lines * 2 + 22) / 45)
exe 'vert 3resize ' . ((&columns * 79 + 80) / 160)
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0&& getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToOFc
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
