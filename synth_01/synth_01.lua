engine.name = 'Synth_01'

function init()

end

function key(z)
  if z == 1 then
    engine.play(1)
    redraw()
  end
end

function redraw()
  screen.clear()
  screen.move(64,32)
  screen.text("Press K3 to play")
  screen.update()
end