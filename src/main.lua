
Thing = {}

things = {}

function Thing:new(o)
   o = o or {}
   setmetatable(o, self)
   self.__index = self

   o.vx = o.vx or 0
   o.vy = o.vy or 0
   o.ax = o.ax or 0
   o.ay = o.ay or 0

   table.insert(things, o)

   return o
end

function Thing:remove()
   for i, v in ipairs(things) do
      if rawequal(v,self) then
	 table.remove(things,i)
	 return
      end
   end
end

scale=4

function Thing:draw()
   love.graphics.draw(self.sprite, scale*(self.x-self.ox), scale*(self.y-self.oy))
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

function Thing:collide(thing) end
function Thing:outside()
   self:remove()
end

--

updatehooks = {}

binds = {}

function bindAll(t)
   for k, ac in pairs(t) do
      binds[k] = ac
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

      for _, s in ipairs(things) do
	 if math.abs(t.x-s.x)<=2 and math.abs(t.y-s.y)<=2 then
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

dofile("src/player.lua")
dofile("src/enemy.lua")