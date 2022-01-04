engine.name="Synth_01"

-- this variable shows if the synth is playing
play_sound=false

-- This function runs when the script starts
function init()
  engine.amp(0) -- default is off

  -- lets add some parameters
  params:add{type="control",id="amp",name="amp",
    -- controlspec is the control
    -- this one goes from 0-1, linearly, default is 0.5 and the
    -- step size is 0.01 and it shows the word "amp" next to it
    controlspec=controlspec.new(0,1.0,'lin',0,0.5,'amp',0.01/0.5),
    action=function(v)
      print("new amp: "..v)
      if play_sound then
        engine.amp(v) -- engine.amp comes from the Engine_Droning
      end
    end
  }

  -- update drawing
  clock.run(redrawer)
end

-- key(<key>,<off/on>) is a special function
-- that listens to the norns keys
function key(k,z)
  if z==1 then
    play_sound=not play_sound
    if play_sound then
      print("playing sound!")
      engine.amp(params:get("amp"))
    else
      print("stopping sound!")
      engine.amp(0)
    end
  end
end

-- enc(<knob>,<turn>) is a special function
-- that listens to the turn of the knob
function enc(k,d)
  if k==3 then
    params:delta("amp",d)
  end
end

-- redraw is a special function that will
-- draw stuff on the screen
function redraw()
  screen.clear()
  screen.level(15)
  screen.font_size(8)
  screen.move(64,20)
  if play_sound then
    screen.text_center("press any key to stop")
  else
    screen.text_center("press any key to play")
  end
  screen.move(64,30)
  screen.move(64,40)
  screen.text_center("amp: "..params:get("amp"))
  screen.update()
end

-- redrawer simply constantly redraws the screen
function redrawer()
  while true do
    clock.sleep(1/15)
    redraw()
  end
end
