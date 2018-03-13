" Functions: {{{1
function! fist#fist(type, update, ...)
  if a:0                             " Invoked from visual mode
    silent execute 'normal! gvy'
  elseif a:type ==# "char"           " Invoked from a characterwise motion
    silent execute "normal! `[v`]y"
  else                               " Invoked from a linewise motion
    silent execute "normal! '[V']y"
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
  let @f = @*
endfunction

function! fist#fistnew(type)
  call s:fist(a:type, "")
endfunction

function! fist#fistupdate(type)
  call s:fist(a:type, ' -u ' . @f)
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
