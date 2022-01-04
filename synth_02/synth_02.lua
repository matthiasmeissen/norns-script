engine.name = 'Synth_02'

function init()
  redraw()
end

function key(k,z)
  if k==2 and z == 1 then
    engine.play(1)
    screen.clear()
    screen.move(64,32)
    screen.text_center("Pressed")
    screen.update()
  else
    redraw()
  end
end

function redraw()
  screen.clear()
  screen.move(64,32)
  screen.text_center("Press K3 to play")
  screen.update()
end
