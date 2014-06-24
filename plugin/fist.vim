" fist.vim:    For super simple gisting from Vim
" Maintainer:  Akshay Hegde <http://github.com/ajh17>
" Version:     1.0
" Website:     <http://github.com/ajh17/vim-fist>

" Vimscript Setup: {{{1
if !executable('gist')
    finish
endif
if exists("g:loaded_vimfist") || v:version < 703 || &compatible
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

" Functions: {{{1
function! Fist()
    let s:fist_command = ""
    if g:fist_anonymously
        let s:fist_command .= "a"
    endif
    if g:fist_opens_browser
        let s:fist_command .= "o"
    endif
    if g:fist_in_private
        let s:fist_command .= "p"
    endif
    silent execute "!gist -Pcs" . s:fist_command . " -f " . bufname("%")
    redraw!
endfunction

" Maps: {{{1
nnoremap <buffer><leader>p :call Fist()<CR>
if has("unix")
    if system('uname') =~ 'Darwin'
        xnoremap <buffer><leader>p :<C-u>let @* = getline("'<,'>")<CR>:call Fist()<CR>
    else
        xnoremap <buffer><leader>p :<C-u>let @+ = getline("'<,'>")<CR>:call Fist()<CR>
    endif
endif
