" Fist of Vim - Super simple and fast gisting for Vim
" Maintainer:  Akshay Hegde <http://github.com/ajh17>
" Version:     1.6
" Website:     <http://github.com/ajh17/vim-fist>

" Vimscript Setup: {{{1
if exists("g:loaded_vimfist") || v:version < 703 || &compatible || !executable('gist')
  finish
endif
let g:loaded_vimfist = 1

" Options: {{{1
if !exists('g:fist_anonymously')
  let g:fist_anonymously = 1
endif

if !exists('g:fist_in_private')
  let g:fist_in_private = 0
endif

if !exists('g:fist_opens_browser')
  let g:fist_opens_browser = 1
endif

if !exists('g:fist_no_maps')
  let g:fist_no_maps = 0
endif

if !exists('g:fist_dispatch')
  let g:fist_dispatch = 0
endif

" Functions: {{{1
function! s:fist(type, update, ...)
  if a:0                             " Invoked from visual mode
    silent exe "normal! gvy"
  elseif a:type ==# "char"           " Invoked from a characterwise motion
    silent exe "normal! `[v`]y"
  else                               " Invoked from a linewise motion
    silent exe "normal! '[V']y"
  endif

  let s:fist_command = ""
  if g:fist_opens_browser
    let s:fist_command .= "o"
  endif
  if g:fist_in_private
    let s:fist_command .= "p"
  endif
  if g:fist_anonymously
    let s:fist_command .= "a"
    silent execute "!gist -Pc" . s:fist_command . "f " . bufname("%")
  else
    silent execute "!gist -Pc" . s:fist_command . a:update . "f " . bufname("%")
  endif

  redraw!
  let @f = @*
endfunction

function! s:fistnew(type)
  call s:fist(a:type, "")
endfunction

function! s:fistupdate(type)
  call s:fist(a:type, "u" . @f)
endfunction

function! s:fistlist()
  let gists = system("gist -l")
  let list = []
  for line in split(gists, '\n')
    if line =~# ':'
      call add(list, {'text': matchstr(line, ' \zs.*'), 'filename': matchstr(line, 'http\S\+')})
    endif
  endfor
  return list
endfunction

" Maps: {{{1
nnoremap <silent> <plug>fov_new           :<C-u>set opfunc=<SID>fistnew<CR>g@
nnoremap <silent> <plug>fov_update        :<C-u>set opfunc=<SID>fistupdate<CR>g@
xnoremap <silent> <plug>fov_visual_new    :<C-u>call <SID>fist(visualmode(), "", 1)<CR>
xnoremap <silent> <plug>fov_visual_update :<C-u>call <SID>fist(visualmode(), "u" . @f, 1)<CR>
if g:fist_dispatch && exists(":Dispatch")
  nnoremap <silent> <plug>fov_list          :Dispatch gist -l<CR>
else
  nnoremap <silent> <plug>fov_list          :call setqflist(<SID>fistlist()) <bar> copen<CR>
endif

if !g:fist_no_maps
  nmap <leader>p <plug>fov_new
  xmap <leader>p <plug>fov_visual_new
  nmap <leader>u <plug>fov_update
  xmap <leader>u <plug>fov_visual_update
  if filereadable($HOME."/.gist")
      nmap <leader>l <plug>fov_list
  endif
endif
