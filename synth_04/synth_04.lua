-- scriptname: Synth_04
-- v1.0.0

engine.name = 'Synth_04'

function init()
  x = 1
  y = 1
  play = false  
end

function key(n,z)
  if n == 2 and z == 1 then
    play = not play
    redraw()
  end
end

function enc(n,d)
  if n == 2 then
    x = x + d
  elseif n == 3 then
    y = y + d
  end
  redraw()
end

function redraw()
  screen.clear()
  screen.level(15)
  screen.move(0, 10)
  screen.text("X: " .. x .. " Y: " .. y)
  
  if play then
    screen.rect(x, y, 10, 10)
    screen.stroke()
    screen.rect(x+2, y+2, 5, 5)
    screen.fill()
    screen.update()
  else
    screen.rect(x, y, 10, 10)
    screen.stroke()
    screen.update()
  end
end
