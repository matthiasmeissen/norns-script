-- scriptname: Synth_03
-- v1.0.0

engine.name = 'Synth_03'

function init()
  x = 1
  y = 1
  play = false
  
  -- for simple things
  params:add_number("amp", "amp", 
    0,  -- min
    0.2,  -- max
    0   -- default
  )
  
  params:set_action("amp", 
    function(x)
      engine.amp(x)
      print(x)
    end
  )
  
  -- for complex things
  params:add_control("cutoff","cutoff", 
    controlspec.new(
      100,    -- min
      8000,   -- max
      'exp',  -- curve
      10,     -- step
      2000,   -- default
      'hz'    -- unit
    )
  )
  
  params:set_action("cutoff",
    function(x)
      engine.cutoff(x)
      print(x)
    end
  )
  
end

function key(n,z)
  if n == 2 and z == 1 then
    play = not play
    redraw()
  end
  if play then 
    params:set("amp", 0.2)
  else
    params:set("amp", 0)
  end
end

function enc(n,d)
  if n == 2 then
    x = x + d
    params:set("cutoff", (x / 128) * 8000)
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
