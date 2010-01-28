
Thing = {}

function Thing:new(o)
   o = o or {}
   setmetatable(o, self)
   self.__index = self

   o.vx = o.vx or 0
   o.vy = o.vy or 0
   o.ax = o.ax or 0
   o.ay = o.ay or 0

   return o
end

function Thing:draw()
   love.graphics.draw(self.sprite, self.x-self.ox, self.y-self.oy)
end

function Thing:update(dt)
   self.x = self.x + dt*self.vx
   self.y = self.y + dt*self.vy
end

function Thing:accel(dvx, dvy)
   self.vx = self.vx + dvx
   self.vy = self.vy + dvy
end

function Thing:move(dx, dy)
   self.x = self.x + dx
   self.y = self.y + dy
end

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

--

things = {ship}

function removething(thing)
   for i, v in ipairs(things) do
      if rawequal(v,thing) then
	 table.remove(things,i)
	 return
      end
   end
end

function newenemy()
   
   if math.random() < 0.99 then
      return
   end

   local enemy = Thing:new {
      sprite = love.graphics.newImage("enemy1.png"),
      ox = 32, oy = 32,
      y = 0, x = math.random(love.graphics.getWidth()),
      vx = 0, vy = math.random(100)}

   function enemy:update(dt)
      Thing.update(self, dt)
      if self.y > love.graphics.getHeight() then
	 removething(self)
      end
   end

   table.insert(things,enemy)
end

updatehooks = {newenemy, function() print(table.maxn(things)) end}

--

speed = 3

binds = {
   s = function () ship:move(0,speed) end,
   d = function () ship:move(speed,0) end,
   w = function () ship:move(0,-speed) end,
   a = function () ship:move(-speed,0) end,

   down =  function () ship:move(0,speed) end,
   right = function () ship:move(speed,0) end,
   up =    function () ship:move(0,-speed) end,
   left =  function () ship:move(-speed,0) end,
}

--

function love.update(dt)

   for _, hook in ipairs(updatehooks) do
      hook()
   end

   for key, action in pairs(binds) do
      if love.keyboard.isDown(key) then
	 --print("event", key)
	 action()
      end
   end

   for _, t in ipairs(things) do
      t:update(dt)
   end
end

function love.draw()
   for _, t in ipairs(things) do
      t:draw()
   end
end

