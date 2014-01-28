"--------------------------------------------------------------------------------
"     File Name           :     smartRename.vim
"     Created By          :     FuDesign2008<FuDesign2008@163.com>
"     Creation Date       :     [2014-01-28 12:24]
"     Last Modified       :     [2014-01-28 15:22]
"     Description         :     auto highlight word under cursor
"
"     inspired by:
"     http://vim.wikia.com/wiki/Auto_highlight_current_word_when_idle
"--------------------------------------------------------------------------------

if exists('g:auto_highlight_loaded')
    finish
endif

let g:auto_highlight_loaded = 1
let s:save_cpo = &cpo
set cpo&vim

if !exists('g:auto_highlight_enable')
    let g:auto_highlight_enable = 1
endif


" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
"
function! s:AutoHighlightEnable()
    augroup auto_highlight
      au!
      au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=600
    echo 'Highlight current word: ON'
endfunction

function! s:AutoHighlightDisable()
    let @/ = ''
    setl updatetime=4000
    if exists('#auto_highlight')
        au! auto_highlight
        augroup! auto_highlight
    endif
    echo 'Highlight current word: off'
endfunction

function! s:AutoHighlightToggle()
  if exists('#auto_highlight')
      call s:AutoHighlightDisable()
  else
      call s:AutoHighlightEnable()
  endif
endfunction

if g:auto_highlight_enable
    autocmd BufEnter call s:AutoHighlightEnable()
endif

command! -nargs=0 AutoHi call s:AutoHighlightToggle()

let &cpo = s:save_cpo
unlet s:save_cpo
