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
badd +2 migrations/2_deploy_contracts.js
badd +1 contracts/UserContract.sol
badd +1 contracts/Rooms.sol
badd +1 test/Users.js
badd +1 test/Rooms.js
badd +6 contracts/lib/Utility.sol
badd +2 test/config.json
badd +48 contracts/Bookings.sol
badd +46 test/Bookings.js
argglobal
%argdel
edit contracts/Rooms.sol
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 80 + 80) / 160)
exe 'vert 2resize ' . ((&columns * 79 + 80) / 160)
argglobal
balt contracts/Bookings.sol
let s:l = 1 - ((0 * winheight(0) + 21) / 43)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
wincmd w
argglobal
if bufexists("contracts/Bookings.sol") | buffer contracts/Bookings.sol | else | edit contracts/Bookings.sol | endif
if &buftype ==# 'terminal'
  silent file contracts/Bookings.sol
endif
balt contracts/Rooms.sol
let s:l = 74 - ((26 * winheight(0) + 21) / 43)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 74
normal! 0
wincmd w
2wincmd w
exe 'vert 1resize ' . ((&columns * 80 + 80) / 160)
exe 'vert 2resize ' . ((&columns * 79 + 80) / 160)
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
