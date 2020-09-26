" =============================================================================
" Filename: autoload/lightline/colorscheme/base16.vim
" Author: shebang
" Author: itchyny
" License: MIT License
" Last Change: 2013/09/07 12:23:38.
" =============================================================================
" base00 - Default Background
" base01 - Lighter Background (Used for status bars)
" base02 - Selection Background
" base03 - Comments, Invisibles, Line Highlighting
" base04 - Dark Foreground (Used for status bars)
" base05 - Default Foreground, Caret, Delimiters, Operators
" base06 - Light Foreground (Not often used)
" base07 - Light Background (Not often used)
" base08 - Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
" base09 - Integers, Boolean, Constants, XML Attributes, Markup Link Url
" base0A - Classes, Markup Bold, Search Text Background
" base0B - Strings, Inherited Class, Markup Code, Diff Inserted
" base0C - Support, Regular Expressions, Escape Characters, Markup Quotes
" base0D - Functions, Methods, Attribute IDs, Headings
" base0E - Keywords, Storage, Selector, Markup Italic, Diff Changed
" base0F - Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>


function! s:base16_color(default, source) abort
  let new_color = a:default
  for func_def in a:source
    let func = 'color#' . func_def[0]
    let new_color = call(func, [ new_color ] + func_def[1])
  endfor
  return '#'.substitute(new_color, '#', '', 'g')
endfunction


function! s:compile_palette(palette) abort

  let s:base16_palette = {}
  for [mode, mode_palette] in items(a:palette)
    let s:base16_palette[mode] = {}

    let pos = ['left', 'middle', 'right']
    for pos in keys(mode_palette)
      let s:base16_palette[mode][pos] = []
    endfor

    for [pos, pos_palette] in items(mode_palette)
      for color_pair in pos_palette
        if has_key(color_pair[0], 'color') && has_key(color_pair[1], 'color')
          let color_fg = s:base16_color(color_pair[0]['color'], color_pair[0]['transform'])
          let color_bg = s:base16_color(color_pair[1]['color'], color_pair[1]['transform'])
          let s:base16_palette[mode][pos] = add(s:base16_palette[mode][pos],[ color_fg, color_bg ] )
        endif
      endfor
    endfor
  endfor
  return s:base16_palette
endfunction

function! s:create_palette() abort
  let insert_fg = g:base16_gui00
  let insert_bg = g:base16_gui08
  let visual_fg = g:base16_gui00
  let visual_bg = g:base16_gui0B
  let replace_fg = g:base16_gui00
  let replace_bg = g:base16_gui09
  let testfile_fg = g:base16_gui00
  let testfile_bg = g:base16_gui0D

  let success_fg = g:base16_gui00
  let success_bg = g:base16_gui08
  let warning_fg = g:base16_gui00
  let warning_bg = g:base16_gui0D
  let error_fg = g:base16_gui00
  let error_bg = g:base16_gui0F


  let s:base16_palette = {}

  let base16 = {}
  let base16.normal = {
    \ 'left': [
      \ [ { 'color': '#'.g:base16_gui04, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.g:base16_gui03, 'transform': [ ['darken', [20]] ] }],
      \ [ { 'color': '#'.g:base16_gui04, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.g:base16_gui01, 'transform': [ ['lighten', [70]] ] }],
      \ [ {'1color': '#'.g:base16_gui04, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.g:base16_gui01, 'transform': [ ['lighten', [70]] ] }],
    \ ],
    \ 'middle': [
      \ [ { 'color': '#'.g:base16_gui04, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.g:base16_gui01, 'transform': [ ['lighten', [0]] ] }],
      \ [ {'1color': '#'.g:base16_gui04, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.g:base16_gui01, 'transform': [ ['lighten', [0]] ] }],
      \ [ {'1color': '#'.g:base16_gui04, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.g:base16_gui01, 'transform': [ ['lighten', [0]] ] }],
    \ ],
    \ 'right': [
      \ [ { 'color': '#'.g:base16_gui04, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.g:base16_gui03, 'transform': [ ['darken', [20]] ] }],
      \ [ {'color': '#'.g:base16_gui04, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.g:base16_gui01, 'transform': [ ['lighten', [70]] ] }],
      \ [ {'color': '#'.g:base16_gui04, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.g:base16_gui01, 'transform': [ ['lighten', [70]] ] }],
    \ ],
    \ 'success': [
      \ [ { 'color': '#'.success_fg, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.success_bg, 'transform': [ ['lighten', [0]] ] }],
    \ ],
    \ 'warning': [
      \ [ { 'color': '#'.warning_fg, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.warning_bg, 'transform': [ ['lighten', [0]] ] }],
    \ ],
    \ 'error': [
      \ [ { 'color': '#'.error_fg, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.error_bg, 'transform': [ ['lighten', [0]] ] }],
    \ ],
    \ 'testfile': [
      \ [ { 'color': '#'.testfile_fg, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.testfile_bg, 'transform': [ ['lighten', [0]] ] }],
    \ ],
    \ 'filename': [
      \ [ { 'color': '#'.g:base16_gui04, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.g:base16_gui01, 'transform': [ ['lighten', [70]] ] }],
    \ ],
  \ }
  let base16.tabline = {
    \ 'tabsel': [
      \ [ { 'color': '#'.g:base16_gui04, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.g:base16_gui02, 'transform': [ ['lighten', [0]] ] }],
      \ [ {'color': '#'.g:base16_gui04, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.g:base16_gui02, 'transform': [ ['lighten', [0]] ] }],
      \ [ {'color': '#'.g:base16_gui04, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.g:base16_gui02, 'transform': [ ['lighten', [0]] ] }],
    \ ],
    \ 'left': [
      \ [ { 'color': '#'.g:base16_gui04, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.g:base16_gui01, 'transform': [ ['lighten', [0]] ] }],
      \ [ {'color': '#'.g:base16_gui04, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.g:base16_gui01, 'transform': [ ['lighten', [0]] ] }],
      \ [ {'color': '#'.g:base16_gui04, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.g:base16_gui01, 'transform': [ ['lighten', [0]] ] }],
    \ ],
    \ 'middle': [
      \ [ { 'color': '#'.g:base16_gui04, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.g:base16_gui01, 'transform': [ ['lighten', [0]] ] }],
      \ [ {'color': '#'.g:base16_gui04, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.g:base16_gui01, 'transform': [ ['lighten', [0]] ] }],
      \ [ {'color': '#'.g:base16_gui04, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.g:base16_gui01, 'transform': [ ['lighten', [0]] ] }],
    \ ],
    \ 'right': [
      \ [ { 'color': '#'.g:base16_gui04, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.g:base16_gui01, 'transform': [ ['lighten', [0]] ] }],
      \ [ {'color': '#'.g:base16_gui04, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.g:base16_gui01, 'transform': [ ['lighten', [0]] ] }],
      \ [ {'color': '#'.g:base16_gui04, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.g:base16_gui01, 'transform': [ ['lighten', [0]] ] }],
    \ ],
  \ }
   let base16.inactive = {
    \ 'left': [
      \ [ { 'color': '#'.g:base16_gui04, 'transform': [ ['darken', [30]] ] },
        \ { 'color': '#'.g:base16_gui01, 'transform': [ ['darken', [50]] ] }],
      \ [ {'color': '#'.g:base16_gui04, 'transform': [ ['darken', [30]] ] },
        \ { 'color': '#'.g:base16_gui01, 'transform': [ ['darken', [50]] ] }],
      \ [ {'color': '#'.g:base16_gui04, 'transform': [ ['darken', [30]] ] },
        \ { 'color': '#'.g:base16_gui01, 'transform': [ ['darken', [50]] ] }],
    \ ],
    \ 'middle': [
      \ [ { 'color': '#'.g:base16_gui04, 'transform': [ ['darken', [30]] ] },
        \ { 'color': '#'.g:base16_gui01, 'transform': [ ['darken', [50]] ] }],
      \ [ {'color': '#'.g:base16_gui04, 'transform': [ ['darken', [30]] ] },
        \ { 'color': '#'.g:base16_gui01, 'transform': [ ['darken', [50]] ] }],
      \ [ {'color': '#'.g:base16_gui04, 'transform': [ ['darken', [30]] ] },
        \ { 'color': '#'.g:base16_gui01, 'transform': [ ['darken', [50]] ] }],
    \ ],
    \ 'right': [
      \ [ { 'color': '#'.g:base16_gui04, 'transform': [ ['darken', [30]] ] },
        \ { 'color': '#'.g:base16_gui01, 'transform': [ ['darken', [50]] ] }],
      \ [ {'color': '#'.g:base16_gui04, 'transform': [ ['darken', [30]] ] },
        \ { 'color': '#'.g:base16_gui01, 'transform': [ ['darken', [50]] ] }],
      \ [ {'color': '#'.g:base16_gui04, 'transform': [ ['darken', [30]] ] },
        \ { 'color': '#'.g:base16_gui01, 'transform': [ ['darken', [50]] ] }],
    \ ],
  \ }
  let base16.visual = {
    \ 'left': [
      \ [ { 'color': '#'.visual_fg, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.visual_bg, 'transform': [ ['lighten', [10]] ] }],
      \ [ {'color': '#'.visual_fg, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.visual_bg, 'transform': [ ['darken', [10]] ] }],
      \ [ {'color': '#'.visual_fg, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.visual_bg, 'transform': [ ['darken', [30]] ] }],
    \ ],
    \ 'middle': [
      \ [ { 'color': '#'.visual_fg, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.visual_bg, 'transform': [ ['darken', [50]] ] }],
      \ [ {'color': '#'.visual_fg, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.visual_bg, 'transform': [ ['lighten', [0]] ] }],
      \ [ {'color': '#'.visual_fg, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.visual_bg, 'transform': [ ['lighten', [0]] ] }],
    \ ],
    \ 'right': [
      \ [ { 'color': '#'.visual_fg, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.visual_bg, 'transform': [ ['lighten', [10]] ] }],
      \ [ {'color': '#'.visual_fg, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.visual_bg, 'transform': [ ['darken', [10]] ] }],
      \ [ {'color': '#'.visual_fg, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.visual_bg, 'transform': [ ['darken', [30]] ] }],
    \ ],
    \ 'testfile': [
      \ [ { 'color': '#'.visual_fg, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.visual_bg, 'transform': [ ['darken', [30]] ] }],
    \ ],
    \ 'filename': [
      \ [ { 'color': '#'.visual_fg, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.visual_bg, 'transform': [ ['darken', [30]] ] }],
    \ ],
  \ }
  let base16.insert = {
    \ 'left': [
      \ [ { 'color': '#'.insert_fg, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.insert_bg, 'transform': [ ['lighten', [10]] ] }],
      \ [ {'color': '#'.insert_fg, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.insert_bg, 'transform': [ ['darken', [10]] ] }],
      \ [ {'color': '#'.insert_fg, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.insert_bg, 'transform': [ ['darken', [30]] ] }],
    \ ],
    \ 'middle': [
      \ [ { 'color': '#'.insert_fg, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.insert_bg, 'transform': [ ['darken', [50]] ] }],
      \ [ {'color': '#'.insert_fg, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.insert_bg, 'transform': [ ['lighten', [0]] ] }],
      \ [ {'color': '#'.insert_fg, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.insert_bg, 'transform': [ ['lighten', [0]] ] }],
    \ ],
    \ 'right': [
      \ [ { 'color': '#'.insert_fg, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.insert_bg, 'transform': [ ['lighten', [10]] ] }],
      \ [ {'color': '#'.insert_fg, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.insert_bg, 'transform': [ ['darken', [10]] ] }],
      \ [ {'color': '#'.insert_fg, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.insert_bg, 'transform': [ ['darken', [30]] ] }],
    \ ],
    \ 'testfile': [
      \ [ { 'color': '#'.testfile_fg, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.testfile_bg, 'transform': [ ['darken', [30]] ] }],
    \ ],
    \ 'filename': [
      \ [ { 'color': '#'.insert_fg, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.insert_bg, 'transform': [ ['darken', [30]] ] }],
    \ ],
  \ }
  let base16.replace = {
    \ 'left': [
      \ [ { 'color': '#'.replace_fg, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.replace_bg, 'transform': [ ['lighten', [10]] ] }],
      \ [ {'color': '#'.replace_fg, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.replace_bg, 'transform': [ ['darken', [10]] ] }],
      \ [ {'color': '#'.replace_fg, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.replace_bg, 'transform': [ ['darken', [30]] ] }],
    \ ],
    \ 'middle': [
      \ [ { 'color': '#'.replace_fg, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.replace_bg, 'transform': [ ['darken', [50]] ] }],
      \ [ {'color': '#'.replace_fg, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.replace_bg, 'transform': [ ['lighten', [0]] ] }],
      \ [ {'color': '#'.replace_fg, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.replace_bg, 'transform': [ ['lighten', [0]] ] }],
    \ ],
    \ 'right': [
      \ [ { 'color': '#'.replace_fg, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.replace_bg, 'transform': [ ['lighten', [10]] ] }],
      \ [ {'color': '#'.replace_fg, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.replace_bg, 'transform': [ ['darken', [10]] ] }],
      \ [ {'color': '#'.replace_fg, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.replace_bg, 'transform': [ ['darken', [30]] ] }],
    \ ],
    \ 'testfile': [
      \ [ { 'color': '#'.replace_fg, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.replace_bg, 'transform': [ ['darken', [30]] ] }],
    \ ],
    \ 'filename': [
      \ [ { 'color': '#'.replace_fg, 'transform': [ ['darken', [0]] ] },
        \ { 'color': '#'.replace_bg, 'transform': [ ['darken', [30]] ] }],
    \ ],
  \ }

  let s:base16_palette = s:compile_palette( base16 )

endfunction

function! lightline#colorscheme#base16#_palette() abort
  if !exists('s:base16_palette')
    call s:create_palette()
  endif
  return s:base16_palette
endfunction

function! lightline#colorscheme#base16#init() abort
  if !exists('g:base16_gui01')
    echoerr 'g:base16_gui01 not defined'
    return
  endif
  let g:lightline#colorscheme#base16#palette = lightline#colorscheme#fill(lightline#colorscheme#base16#_palette())

endfunction


call lightline#colorscheme#base16#init()


