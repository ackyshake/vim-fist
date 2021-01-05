" Fist of Vim - Super simple and fast gisting for Vim
" Description: Main plugin file
" Maintainer:  Akshay Hegde <http://github.com/ackyshake>
" Version:     1.8
" Website:     <http://github.com/ackyshake/vim-fist>

" Vimscript Setup: {{{1
if exists("g:loaded_vimfist") || v:version < 703 || &compatible
  finish
endif
if !executable('gist')
  finish
endif
let g:loaded_vimfist = 1

" Options: {{{1
if !exists('g:fist_in_private')
  let g:fist_in_private = 1
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

" Maps: {{{1
nnoremap <silent> <plug>fov_new           :<C-u>set opfunc=fist#fistnew<CR>g@
nnoremap <silent> <plug>fov_update        :<C-u>set opfunc=fist#fistupdate<CR>g@
xnoremap <silent> <plug>fov_visual_new    :<C-u>call fist#fist(visualmode(), "", 1)<CR>
xnoremap <silent> <plug>fov_visual_update :<C-u>call fist#fist(visualmode(), ' -u ' . @f, 1)<CR>
if g:fist_dispatch && exists(":Dispatch")
  nnoremap <silent> <plug>fov_list          :Dispatch gist -l<CR>
else
  nnoremap <silent> <plug>fov_list          :call setqflist(fist#fistlist()) <bar> copen<CR>
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
