" George Marsaglia's Multiply-with-carry Random Number Generator {{{
" Modified to work within Vim's semantics
let s:m_w = matchstr(tempname(), '\d\+') * getpid()
let s:m_z = localtime()

" not sure of the wisdom of generating a full 32-bit RN here
" and then using abs() on the sucker. Feedback welcome.
function! RandomNumber()
  let s:m_z = (36969 * and(s:m_z, 0xffff)) + (s:m_z / 65536)
  let s:m_w = (18000 * and(s:m_w, 0xffff)) + (s:m_w / 65536)
  return (s:m_z * 65536) + s:m_w      " 32-bit result
endfunction
" end RNG }}}

" RandomChar(base, cap)
"   base : the lowest char number desired
"   cap  : the highest char number desired
" Defaults to ASCII characters in the range
" 33-126 (!-~)
" But it's capable of much wider character tables
function! RandomChar(...)
  let base = 33
  let cap = 126
  if a:0 > 0
    let base = a:1
  endif
  if a:0 > 1
    let cap = a:2
  endif
  let adj = abs(cap - base) + 1
  return nr2char(RandomNumber() % adj + base)
endfunction

function! RandomCharsInSet(length, set)
  let from = join(map(range(len(a:set)), 'nr2char(char2nr("a")+v:val)'), '')
  let to = join(a:set, '')
  return map(RandomChars(a:length, 97, 96+len(a:set)), 'tr(v:val, from, to)')
endfunction

function! RandomChars(length, ...)
  let args = []
  if a:0 > 0
    if type(a:1) == type([])
      let args = a:1
    else
      let args = a:000
    endif
  endif
  return map(repeat([0], a:length), 'call("RandomChar", args)')
endfunction

function! RandomString(length, ...)
  let args = []
  if a:0 > 0
    if type(a:1) == type([])
      let args = a:1
    else
      let args = a:000
    endif
  endif
  return join(call('RandomChars', [a:length, args]), '')
endfunction

