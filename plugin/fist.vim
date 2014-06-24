" fist.vim:    For super simple gisting from Vim
" Maintainer:  Akshay Hegde <http://github.com/ajh17>
" Version:     0.1
" Website:     <http://github.com/ajh17/vim-fist>

" Vimscript Setup: {{{1
if exists("g:loaded_vimfist") || v:version < 703 || &compatible
    finish
endif
let g:loaded_vimfist = 1

" Options: {{{1
if !exists('g:fist_anonymous')
    let g:fist_anonymous = 0
endif

if !exists('g:fist_open_browser')
    let g:fist_open_browser = 1
endif

" Functions: {{{1
function! s:fist(args)
endfunction

" Maps: {{{1
