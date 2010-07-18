ship = Thing:new{
   sprite = love.graphics.newImage("ship.png"),
   ox = 32, oy = 32,
   bb = 1,
   x = 100.0, y = 600.0,
   type = "player",
   cooldown=0,
   absorbcooldown=0,
   absorbleft=0,
}

speed = 300
absorbtime = 0.2
absorbcooldown = 1
bulletspeed = 500
weaponcooldown = 0.3

binds = {
   s = function () ship:accel(0,speed) end,
   d = function () ship:accel(speed,0) end,
   w = function () ship:accel(0,-speed) end,
   a = function () ship:accel(-speed,0) end,

   down =  function () ship:accel(0,speed) end,
   right = function () ship:accel(speed,0) end,
   up =    function () ship:accel(0,-speed) end,
   left =  function () ship:accel(-speed,0) end,

   [" "] = function () ship:shoot() end,
   v = function() ship:absorb() end,
}

function max(x,y)
   if x > y then
      return x
   else
      return y
   end
end

function ship:update(dt)
   self.cooldown = max(0,self.cooldown - dt)
   self.absorbcooldown = max(0,self.absorbcooldown - dt)
   self.absorbleft = max(0,self.absorbleft - dt)

   self:stop()
   
   for k,cb in pairs(binds) do
      if love.keyboard.isDown(k) then
	 cb()
      end
   end

   self.x = self.x + dt*self.vx
   self.y = self.y + dt*self.vy

   
end

function ship:draw()
   if self.absorbleft > 0 then
      love.graphics.circle("line",self.x,self.y,
			   5+25*self.absorbleft/absorbtime)
   end
   love.graphics.draw(self.sprite,
		      self.x-self.ox,
		      self.y-self.oy)
end

function ship:outside()

   local w = love.graphics.getWidth()
   local h = love.graphics.getHeight()

   if self.x < 0 then self.x = 0 self.vx = 0 end
   if self.y < 0 then self.y = 0 self.vy = 0 end
   if self.x > w then self.x = w self.vx = 0 end
   if self.y > h then self.y = h self.vy = 0 end
end

function ship:collide(thing)
   if self.absorbleft > 0 then
      return
   end
   if thing.type=="enemy" or thing.type=="enemybullet" then
      self:remove()
   end
end

function ship:shoot()

   if self.cooldown > 0 then return end

   bullet = Thing:new {sprite = love.graphics.newImage("bullet.png"),
		       ox = 32, oy = 32,
		       bb = 4,
	               x = self.x, y = self.y - 12, type = "bullet",
		       vy = -bulletspeed, vx = 0}

   function bullet:collide(thing)
      self:remove()
   end

   self.cooldown = weaponcooldown
end

function ship:absorb()

   if self.absorbcooldown > 0 then return end
   self.absorbleft = absorbtime
   self.absorbcooldown = absorbcooldown

end