dofile("src/thing.lua")

updatehooks = {}

function love.update(dt)

   for _, hook in ipairs(updatehooks) do
      hook()
   end

   for _, t in ipairs(things) do
      t:update(dt)

      for _, s in ipairs(things) do
	 
	 if t.bb and s.bb and
	    math.abs(t.x+t.ox-s.x-s.ox)<=t.bb+s.bb and
	    math.abs(t.y+t.oy-s.y-s.oy)<=t.bb+s.bb and
            not rawequal(t,s)
	 then
	    --print("collide",t.type,s.type)
	    t:collide(s)
	    s:collide(t)
	 end
      end

      if t.x<0 or t.x>love.graphics.getWidth() or t.y<0 or t.y>love.graphics.getHeight() then
	 t:outside()
      end
   end
end

function love.draw()
   for _, t in ipairs(things) do
      t:draw()
   end
end

--

love.graphics.setMode(600,800)

dofile("src/explosion.lua")
dofile("src/background.lua")
dofile("src/player.lua")
dofile("src/enemy.lua")
