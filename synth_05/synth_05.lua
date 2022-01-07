-- scriptname: Synth_05
-- v1.0.0

engine.name = 'Synth_05'

function init()
  x = 20
  y = 60
  play = false 
  c = 20
  r = 40
  
  current_screen = 0
end

function key(n,z)
  if n == 2 and z == 1 then
    play = not play
    engine.play(1)
    redraw()
  end
end

function enc(n,d)
  if n == 1 then
    if d > 0 then
      current_screen = 1
    elseif d < 0 then
      current_screen = 0
    end
  elseif n == 2 then
    c = util.clamp(c + d, 1, 128)
    engine.cutoff((c / 128) * 20000) 
  elseif n == 3 then
    r = util.clamp(r + d, 1, 128)
    engine.resonance(r / 128)
  end
  
  redraw()
end

function redraw()
  screen.clear()
  
  if current_screen == 0 then
    draw_page(65, 1, "Screen 1")
    draw_filter(c, r)
  else
    draw_page(1, 65, "Screen 2")
  end
  
  screen.update()
end

function draw_filter(cut, res)
  cut = (cut * 0.8) + 10
  res = (res / 128) * 10
  screen.move(0, 32)
  screen.line(cut - 4, 32)
  screen.line_rel(4, -res)
  screen.line(cut + 10, 50)
  screen.stroke()
end

function draw_page(x, y, name)
  screen.level(2)
  screen.rect(x, 60, 60, 1)
  screen.fill()
  screen.move(0, 10)
  screen.level(15)
  screen.text(name)
  screen.rect(y, 60, 60, 1)
  screen.fill()
end
