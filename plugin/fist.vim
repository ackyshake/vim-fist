" Fist of Vim - For super simple and fast gisting from Vim
" Maintainer:  Akshay Hegde <http://github.com/ajh17>
" Version:     1.3
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
    else
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
nnoremap <silent> <plug>fov_new           :set opfunc=FistNew<CR>g@
nnoremap <silent> <plug>fov_update        :set opfunc=FistUpdate<CR>g@
xnoremap <silent> <plug>fov_visual_new    :<C-u>call Fist(visualmode(), "", 1)<CR>
xnoremap <silent> <plug>fov_visual_update :<C-u>call Fist(visualmode(), " - u " . @f, 1)<CR>

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
