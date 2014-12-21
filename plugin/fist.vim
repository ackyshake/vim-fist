" Fist of Vim - Super simple and fast gisting for Vim
" Maintainer:  Akshay Hegde <http://github.com/ajh17>
" Version:     1.5
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
    silent execute "!gist -Pc" . s:fist_command . " -f " . bufname("%")
  else
    silent execute "!gist -Pc" . s:fist_command . a:update
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
  copen
  return system("gist -l")
endfunction

" Maps: {{{1
if exists(":Dispatch")
  nnoremap <silent> <plug>fov_list          :Dispatch gist -l<CR>
else
  nnoremap <silent> <plug>fov_list          :cexpr <SID>fistlist()<CR>
endif
nnoremap <silent> <plug>fov_new           :<C-u>set opfunc=<SID>fistnew<CR>g@
nnoremap <silent> <plug>fov_update        :<C-u>set opfunc=<SID>fistupdate<CR>g@
xnoremap <silent> <plug>fov_visual_new    :<C-u>call <SID>fist(visualmode(), "", 1)<CR>
xnoremap <silent> <plug>fov_visual_update :<C-u>call <SID>fist(visualmode(), "u" . @f, 1)<CR>

if !g:fist_no_maps
  if !hasmapto('<plug>fov_list')
    nmap <unique><silent> <leader>l <plug>fov_list
  endif
  if !hasmapto('<plug>fov_new')
    nmap <unique><silent> <leader>p <plug>fov_new
  endif
  if !hasmapto('<plug>fov_update')
    nmap <unique><silent> <leader>u <plug>fov_update
  endif
  if !hasmapto('<plug>fov_visual_new')
    xmap <unique><silent> <leader>p <plug>fov_visual_new
  endif
  if !hasmapto('<plug>fov_visual_update')
    xmap <unique><silent> <leader>u <plug>fov_visual_update
  endif
endif
