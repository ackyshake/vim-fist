" fist.vim:    For super simple gisting from Vim
" Maintainer:  Akshay Hegde <http://github.com/ajh17>
" Version:     1.0
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

" Functions: {{{1
function! Fist()
    if !g:fist_anonymous
        silent !gist -Pacos -f <C-r>%<CR>:redraw!<CR>
    elseif
        silent !gist -Pcos -f <C-r>%<CR>:redraw!<CR>
    endif
endfunction

" Maps: {{{1
nnoremap <leader>p :call Fist()
xnoremap <leader>p :norm y | call Fist()
