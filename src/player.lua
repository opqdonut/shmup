ship = Thing:new {sprite = love.graphics.newImage("ship.png"),
		  ox = 32, oy = 32,
	          x = 100.0, y = 100.0}

function ship:update(dt)

   Thing.update(self, dt)

   local w = love.graphics.getWidth()
   local h = love.graphics.getHeight()

   if self.x < 0 then self.x = 0 self.vx = 0 end
   if self.y < 0 then self.y = 0 self.vy = 0 end
   if self.x > w then self.x = w self.vx = 0 end
   if self.y > h then self.y = h self.vy = 0 end
end

table.insert(things, ship)

speed = 3

bindAll {
   s = function () ship:move(0,speed) end,
   d = function () ship:move(speed,0) end,
   w = function () ship:move(0,-speed) end,
   a = function () ship:move(-speed,0) end,

   down =  function () ship:move(0,speed) end,
   right = function () ship:move(speed,0) end,
   up =    function () ship:move(0,-speed) end,
   left =  function () ship:move(-speed,0) end,
}