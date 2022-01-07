-- scriptname: Synth_05
-- v1.0.0

engine.name = 'Synth_05'

function init()
  x = 20
  y = 60
  play = false  
end

function key(n,z)
  if n == 2 and z == 1 then
    play = not play
    engine.play(1)
    redraw()
  end
end

function enc(n,d)
  if n == 2 then
    x = util.clamp(x + d, 0, 100)
    engine.attack(x / 100)
  elseif n == 3 then
    y = util.clamp(y + d, 0, 100)
    engine.release(y / 100)
  end
  redraw()
end

function redraw()
  screen.clear()
  screen.level(15)
  screen.move(60, 32)
  screen.text("Press to play")
  draw_bar(10, 10, x / 100)
  draw_bar(30, 10, y / 100)
  screen.update()
end

function draw_bar(x, y, amount)
  local h = 40
  local x = x
  local y = y
  local amount = 1 - amount
  
  screen.rect(x, y, 10, h)
  screen.stroke()
  screen.rect(x, y + h * amount, 10, h - h * amount)
  screen.fill()
end
