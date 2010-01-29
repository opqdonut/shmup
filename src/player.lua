ship = Thing:new {sprite = love.graphics.newImage("ship.png"),
		  ox = 8, oy = 8,
	          x = 30.0, y = 30.0,
	          type = "player", cooldown=0}

function ship:update(dt)
   self.cooldown = self.cooldown - dt
   if self.cooldown < 0 then self.cooldown = 0 end
end

function ship:outside()

   local w = love.graphics.getWidth()/scale
   local h = love.graphics.getHeight()/scale

   if self.x < 0 then self.x = 0 self.vx = 0 end
   if self.y < 0 then self.y = 0 self.vy = 0 end
   if self.x > w then self.x = w self.vx = 0 end
   if self.y > h then self.y = h self.vy = 0 end
end

function ship:collide(thing)
   if thing.type=="enemy" or thing.type=="bullet" then
      self:remove()
   end
end

function ship:shoot()

   if self.cooldown > 0 then return end

   bullet = Thing:new {sprite = love.graphics.newImage("bullet.png"),
		       ox = 8, oy = 8,
	               x = self.x, y = self.y - 4, type = "bullet",
		       vy = -30, vx = 0}

   self.cooldown = 0.3
end

speed = 1

bindAll {
   s = function () ship:move(0,speed) end,
   d = function () ship:move(speed,0) end,
   w = function () ship:move(0,-speed) end,
   a = function () ship:move(-speed,0) end,

   down =  function () ship:move(0,speed) end,
   right = function () ship:move(speed,0) end,
   up =    function () ship:move(0,-speed) end,
   left =  function () ship:move(-speed,0) end,

   [" "] = function () ship:shoot() end,
}
