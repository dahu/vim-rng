" George Marsaglia's Multiply-with-carry Random Number Generator {{{2
let s:m_w = matchstr(tempname(), '\d\+') * getpid()
let s:m_z = localtime()

" sledge hammer to crack a nut?
" also... not sure of the wisdom of generating a full 32-bit RN here
" and then using abs() on the sucker. But it'll do for now...
function! RandomNumber()
  let s:m_z = s:m_z + (s:m_z / 4)
  let s:m_w = s:m_w + (s:m_w / 4)
  return abs((s:m_z) + s:m_w)      " 32-bit result
endfunction
" end RNG }}}2

function! RandomString(prefix, length, suffix)
  let result = a:prefix
  let randnum = strpart(RandomNumber(), 1, a:length)
  return result . randnum . a:suffix
endfunction

