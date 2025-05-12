vim.g.mapleader = ","
vim.g.maplocalleader = ","

vim.cmd([[
" Base64 encode/decode. Special detection because, of course, OSX has its own
" super special base64 that doesn't do stuff like base64 encode things?
if has("unix")
  vnoremap <leader>64d c<c-r>=system('base64 --decode', @")<cr><esc>

  let s:uname = system("uname -s")
  if s:uname == "Darwin"
    vnoremap <leader>64e c<c-r>=system('base64 -w0', @")<cr><esc>
  else
    vnoremap <leader>64e c<c-r>=system('openssl base64 -e -A', @")<cr><esc>
  endif

  " The pneumonic to remember the mapping is Kubernetes Secret Decode/Encode.
  " You need to linewise visually select the entire secret block (or as much
  " of it as you care to decode) first. I use the vim-indent-object to make
  " this a little faster (vii).
  vnoremap <leader>ksd :'<,'>normal $vT <leader>64d<cr>
  vnoremap <leader>kse :'<,'>normal $vT <leader>64e<cr>
endif
]])

require("config.lazy")
require("config.base")
require("config.maps")
