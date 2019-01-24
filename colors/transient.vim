" Transient 256 - A dark Vim color scheme for xterm-256color
"
" Author: whybin
" Homepage: https://github.com/whybin/Transient-256

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
let s:c7=60   " Dark grayish violet
let s:c8=222  " Yellow
let s:c9=132  " Deep rose
let s:c10=43  " Sea green
let s:c11=111 " Blue violet

" Functions {{{
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

function! s:Highlight(group, fg, ...)
    let bg = exists('a:1') ? a:1 : 'NONE'
    let attr = 'NONE,' . (exists('a:2') ? a:2 : '')
    let exec_str = printf(
                \'hi %s ctermfg=%s ctermbg=%s cterm=%s',
                \a:group, a:fg, bg, attr)

    if has('gui_running')
        let guifg = a:fg != 'NONE' ? s:XtermToGui(a:fg) : a:fg
        let guibg = exists('a:1') && a:1 != 'NONE' ? s:XtermToGui(a:1) : 'NONE'
        let guisp = attr =~ 'under' ? 'guisp=' . guifg : ''
        let exec_str .= printf(
                    \' guifg=%s guibg=%s gui=%s %s', guifg, guibg, attr, guisp)
    endif

    exec exec_str
endfunction
" }}}

set background=dark

" Default Groups {{{
call s:Highlight('Normal', s:c1, s:c0)
call s:Highlight('ColorColumn', 'NONE', s:c2, 'NONE')
hi! link SignColumn ColorColumn
hi! link CursorColumn ColorColumn
hi! link CursorLine ColorColumn
call s:Highlight('Cursor', 'NONE', s:c7)
call s:Highlight('Directory', s:c3)
call s:Highlight('SpecialKey', s:c6)

call s:Highlight('VertSplit', s:c1, s:c1)
call s:Highlight('Folded', s:c5, s:c2)
hi! link FoldColumn Folded

call s:Highlight('MatchParen', s:c6, s:c7, 'bold')
call s:Highlight('NonText', s:c4)
hi! link LineNr NonText

call s:Highlight('DiffAdd', s:c10, s:c7, 'bold')
call s:Highlight('DiffChange', s:c8, s:c7, 'bold')
call s:Highlight('DiffDelete', s:c5, s:c7, 'bold')
call s:Highlight('DiffText', 'NONE', s:c2, 'bold')

call s:Highlight('ModeMsg', s:c6, s:c3)
hi! link MoreMsg ModeMsg
call s:Highlight('ErrorMsg', s:c6, s:c5, 'bold')
call s:Highlight('WarningMsg', s:c8, s:c2, 'bold')
call s:Highlight('Title', s:c6)

call s:Highlight('StatusLine', s:c2, s:c3)
call s:Highlight('StatusLineNC', s:c3, s:c2)
hi! link CursorLineNr StatusLineNC
hi! link Pmenu StatusLineNC
hi! link PmenuSbar StatusLineNC
call s:Highlight('PmenuThumb', s:c6, s:c6)
call s:Highlight('Search', s:c2, s:c3)
call s:Highlight('IncSearch', s:c2, s:c5)
hi! link PmenuSel Search
hi! link Question Search
call s:Highlight('Visual', 'NONE', s:c7)
hi! link WildMenu IncSearch

call s:Highlight('TabLine', s:c10, s:c2)
hi! link TabLineFill TabLine
hi! link TabLineSel StatusLine

call s:Highlight('SpellBad', s:c5, s:c2, 'undercurl')
call s:Highlight('SpellCap', s:c3, s:c2, 'undercurl')
call s:Highlight('SpellLocal', 'NONE', s:c2)
call s:Highlight('SpellRare', 'NONE', s:c2)
" }}}

" Syntax Groups {{{
call s:Highlight('Comment', s:c4)
call s:Highlight('Constant', s:c8)

call s:Highlight('Identifier', s:c9)
hi! link Special Identifier

call s:Highlight('Statement', s:c10)
call s:Highlight('PreProc', s:c6)
call s:Highlight('Type', s:c11)
call s:Highlight('Underlined', s:c10, s:c2)

hi! link Error ErrorMsg
hi! link Todo WarningMsg
" }}}

" Git Groups {{{
call s:Highlight('diffAdded', s:c10, s:c2, 'bold')
call s:Highlight('diffChanged', s:c8, s:c2, 'bold')
call s:Highlight('diffRemoved', s:c5, s:c2, 'bold')
" }}}
" }}}
