" Fist of Vim - Super simple and fast gisting for Vim
" Description: Autoloaded utility functions
" Maintainer:  Akshay Hegde <http://github.com/ackyshake>
" Version:     1.8
" Website:     <http://github.com/ackyshake/vim-fist>

" Functions: {{{1
function! fist#fist(type, update, ...)
  let l:has_unnamedplus = has('unnamedplus')
  if a:0                             " invoked from visual mode
    if l:has_unnamedplus
      silent execute 'normal! gv"+y'
    else
      silent execute 'normal! gv"*y'
    endif
  elseif a:type ==# "char"           " Invoked from a characterwise motion
    if l:has_unnamedplus
      silent execute 'normal! `[v`]"+y'
    else
      silent execute 'normal! `[v`]"*y'
    endif
  else                               " Invoked from a linewise motion
    if l:has_unnamedplus
      silent execute "normal! '[V']\"+y"
    else
      silent execute "normal! '[V']\"*y"
    endif
  endif

  let s:fist_command = ""
  if g:fist_opens_browser
    let s:fist_command .= "o"
  endif
  if g:fist_in_private
    let s:fist_command .= "p"
  endif
  silent execute "!gist -Pc" . s:fist_command . "f " . bufname("%") . a:update

  redraw!
  let @f = l:has_unnamedplus ? @+ : @*
endfunction

function! fist#fistnew(type)
  call fist#fist(a:type, "")
endfunction

function! fist#fistupdate(type)
  call fist#fist(a:type, ' -u ' . @f)
endfunction

function! fist#fistlist()
  let gists = system("gist -l")
  let list = []
  for line in split(gists, '\n')
    if line =~# ':'
      call add(list, {'text': matchstr(line, ' \zs.*'), 'filename': matchstr(line, 'http\S\+')})
    endif
  endfor
  return list
endfunction
