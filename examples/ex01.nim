# adapted from python code linked here by Cfyz:
# http://forums.roguetemple.com/index.php?topic=3896.msg46545#msg46545

import blt

proc init() =
  discard blt.set("font: /usr/share/fonts/TTF/Consolas-Regular.ttf, size=16")
  discard blt.set("input.filter=[keyboard, system]") # Disable mouse to make read() behave like getch()
  discard blt.set("window.size=28x10")
  discard blt.set("terminal.encoding=utf8")
  discard blt.set("window.title='BEARLIBTERMINAL > ESC to quit'")

proc draw_window(x, y, w, h: cint) =
  # Translucent background
  color("#C0A0A0A0")
  put(x,     y,     0x2597) # Corners
  put(x+w-1, y,     0x2596)
  put(x+w-1, y+h-1, 0x2598)
  put(x,     y+h-1, 0x259D)
  for i in x+1..<x+w-1: # Horisontal borders
    put(i, y,     0x2584)
    put(i, y+h-1, 0x2580)
  for i in y+1..<y+h-1: # Vertical borders
    put(x,     i, 0x2590)
    put(x+w-1, i, 0x258C)
  for i in x+1..<x+w-1: # Fill
    for j in y+1..<y+h-1:
      put(i, j, 0x2588)
  # Thin, solid border
  color("white")
  put(x,     y,     0x250C) # Corners
  put(x+w-1, y,     0x2510)
  put(x+w-1, y+h-1, 0x2518)
  put(x,     y+h-1, 0x2514)
  for i in x+1..<x+w-1: # Horisontal borders
    put(i, y,     0x2500)
    put(i, y+h-1, 0x2500)
  for i in y+1..<y+h-1: # Vertical borders
    put(x,     i, 0x2502)
    put(x+w-1, i, 0x2502)

proc checkers() =
  # Checkered background
  for x in 0..<12.cint:
    for y in 0..<8.cint:
      if (x+y) mod 2 == 0:
        color("darker green")
      else:
        color("darker red")
      put(x*2 + 2, y + 1, 0x2588)
      put(x*2 + 3, y + 1, 0x2588)

var run = true
discard open()
init()
composition(true.cint)
clear()
checkers()
draw_window(5, 2, 18, 6)
discard print(8, 4, "[color=white]Hello, Nim!")

refresh()
while run == true:
  while hasInput().bool:
    var key = read()
    if key == TK_CLOSE or key == TK_ESCAPE:
      run = false
close()
