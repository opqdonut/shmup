
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

--

updatehooks = {}

binds = {}

function bindAll(t)
   for k, ac in pairs(t) do
      binds[k] = ac
   end
end

things = {}

function removething(thing)
   for i, v in ipairs(things) do
      if rawequal(v,thing) then
	 table.remove(things,i)
	 return
      end
   end
end

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

--

dofile("src/player.lua")
dofile("src/enemy.lua")