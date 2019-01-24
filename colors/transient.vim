" Transient - A dark colorscheme for xterm-256color
set background=dark
hi clear
if exists('syntax_on')
    syntax reset
endif

let g:colors_name='transient'

let s:c0=236  " Dark gray
let s:c1=103  " Grayish violet
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

function! s:ToHex(val)
    return a:val == 0 ? 0 : a:val * 40 + 55
endfunction

" Encodes the (reversed) 'on' bits of `val` with the value `mult`
" Ex: s:BitEncode(4, 0xff) = 0x0000ff
function! s:BitEncode(val, mult)
    return a:mult * (
                \(and(a:val, 0x1) ? 65536 : 0)
                \+ (and(a:val, 0x2) ? 256 : 0)
                \+ (and(a:val, 0x4) ? 1 : 0))
endfunction

function! s:XtermToGui(xterm_color)
    if a:xterm_color >= 232
        let hex = (a:xterm_color - 232) * 10 + 8
        return printf('#%02x%02x%02x', hex, hex, hex)
    elseif a:xterm_color >= 16
        let tmp = a:xterm_color - 16
        return printf('#%02x%02x%02x',
                    \ s:ToHex(tmp / 36),
                    \ s:ToHex((tmp % 36) / 6),
                    \ s:ToHex(tmp % 6))
    elseif a:xterm_color >= 9
        " Add 1 to value to encode
        return printf('#%06x', s:BitEncode(a:xterm_color - 8, 0xff))
    elseif a:xterm_color == 8
        return '#808080'
    elseif a:xterm_color == 7
        return '#c0c0c0'
    else
        return printf('#%06x', s:BitEncode(a:xterm_color, 0x80))
    endif
endfunction

function! s:highlight(group, fg, ...)
    let bg = exists('a:1') ? a:1 : 'NONE'
    let attr = 'NONE,' . (exists('a:2') ? a:2 : '')
    let exec_str = 'hi ' . a:group . ' ctermfg=' . a:fg . ' ctermbg=' . bg
                \. ' cterm=' . attr

    if has('gui_running')
        let guifg = s:XtermToGui(a:fg)
        let guibg = exists('a:1') ? s:XtermToGui(a:1) : 'NONE'
        let exec_str .= ' guifg=' . guifg . ' guibg=' . guibg . ' gui=' . attr
    endif

    exec exec_str
endfunction

" Default Groups {{{
call <SID>highlight('Normal', s:c1, s:c0)
call <SID>highlight('ColorColumn', 'NONE', s:c2)
hi! link SignColumn ColorColumn
call <SID>highlight('CursorLine', 'NONE', 'NONE')
call <SID>highlight('Directory', s:c3)

call <SID>highlight('VertSplit', s:c1, s:c1)
call <SID>highlight('Folded', s:c5, s:c2)
hi! link FoldColumn Folded

call <SID>highlight('MatchParen', s:c6, s:c7, 'bold')
call <SID>highlight('NonText', s:c4)
hi! link LineNr NonText

call <SID>highlight('DiffAdd', s:c10, s:c2, 'bold')
call <SID>highlight('DiffChange', s:c8, s:c2, 'bold')
call <SID>highlight('DiffDelete', s:c5, s:c2, 'bold')
call <SID>highlight('DiffText', 'NONE', s:c2)

call <SID>highlight('ModeMsg', s:c6, s:c3)
hi! link MoreMsg ModeMsg
call <SID>highlight('ErrorMsg', s:c6, s:c5, 'bold')
call <SID>highlight('WarningMsg', s:c8, s:c2, 'bold')
call <SID>highlight('Title', s:c6)

call <SID>highlight('StatusLine', s:c2, s:c3)
call <SID>highlight('StatusLineNC', s:c3, s:c2)
hi! link CursorLineNr StatusLineNC
hi! link Pmenu StatusLineNC
hi! link PmenuSbar StatusLineNC
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

call <SID>highlight('Statement', s:c10)
call <SID>highlight('PreProc', s:c6)
call <SID>highlight('Type', s:c11)
call <SID>highlight('Underlined', s:c10, s:c2)

hi! link Error ErrorMsg
hi! link Todo WarningMsg
" }}}

" Git Groups {{{
hi! link diffAdded DiffAdd
hi! link diffChanged DiffChange
hi! link diffRemoved DiffDelete
" }}}
