" Fist of Vim - For super simple and fast gisting from Vim
" Maintainer:  Akshay Hegde <http://github.com/ajh17>
" Version:     1.2
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

" Functions: {{{1
function! Fist(type, update, ...)
    if a:0
        silent exe "normal! gvy"
    elseif a:type == 'line'
        silent exe "normal! '[V']y"
    else
        silent exe "normal! `[v`]y"
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
    elseif
        silent execute "!gist -Pc" . s:fist_command . a:update . " -f " . bufname("%")
    endif
    redraw!
    let @f = @*
endfunction

function! FistNew(type)
    call Fist(1, "")
endfunction

function! FistUpdate(type)
    call Fist(visualmode(), " -u " . @f, 1)
endfunction

" Maps: {{{1
nnoremap <silent> <leader>p :set opfunc=FistNew<CR>g@
xnoremap <silent> <leader>p :<C-u>call Fist(visualmode(), "", 1)<CR>
nnoremap <silent> <leader>u :set opfunc=FistUpdate<CR>g@
xnoremap <silent> <leader>u :<C-u>call Fist(visualmode(), " -u " . @f, 1)<CR>
