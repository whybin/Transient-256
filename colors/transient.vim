" Transient - A dark colorscheme for xterm-256color
set background=dark
hi clear
if exists('syntax_on')
    syntax reset
endif

let g:colors_name='transient'

let s:c0=236  " Dark gray
let s:c1=109  " Grayish blue-green
let s:c2=235  " Darker gray
let s:c3=105  " Violet
let s:c4=240  " Light gray
let s:c5=204  " Rose red
let s:c6=194  " Pale chartreuse
let s:c7=60   " Grayish violet
let s:c8=222  " Yellow
let s:c9=132  " Deep rose
let s:c10=43  " Sea green
let s:c11=111 " Blue violet

function! s:highlight(group, fg, ...)
    exec 'hi ' . a:group . ' ctermfg=' . a:fg
                \. ' ctermbg=' . (exists('a:1') ? a:1 : 'NONE')
                \. ' cterm=NONE,' . (exists('a:2') ? a:2 : '')
endfunction

" Default Groups {{{
call <SID>highlight('Normal', s:c1, s:c0)
call <SID>highlight('ColorColumn', 'NONE', s:c2)
call <SID>highlight('CursorLine', 'NONE', 'NONE')
call <SID>highlight('Directory', s:c3)

call <SID>highlight('VertSplit', s:c1, s:c1)
call <SID>highlight('Folded', s:c5, s:c2)
hi! link FoldColumn Folded

call <SID>highlight('NonText', s:c4)
hi! link LineNr NonText

call <SID>highlight('MatchParen', s:c6, s:c3)
hi! link ModeMsg MatchParen
hi! link MoreMsg MatchParen
call <SID>highlight('ErrorMsg', s:c6, s:c5, 'bold')
call <SID>highlight('WarningMsg', s:c8, s:c2, 'bold')

call <SID>highlight('StatusLine', s:c3, s:c2)
call <SID>highlight('StatusLineNC', 'NONE', s:c2)
hi! link CursorLineNr StatusLine
hi! link Pmenu StatusLine
hi! link PmenuSbar StatusLine
call <SID>highlight('Search', s:c2, s:c3)
hi! link PmenuSel Search
hi! link Question Search
call <SID>highlight('Visual', 'NONE', s:c7)
" }}}

" Syntax Groups {{{
call <SID>highlight('Comment', s:c4)
call <SID>highlight('Constant', s:c8)

call <SID>highlight('Identifier', s:c9)
hi! link Special Identifier
call <SID>highlight('Function', s:c5)

call <SID>highlight('Statement', s:c10)
call <SID>highlight('PreProc', s:c6)
call <SID>highlight('Type', s:c11)
call <SID>highlight('Underlined', s:c10, s:c2)

hi! link Error ErrorMsg
hi! link Todo WarningMsg
" }}}
