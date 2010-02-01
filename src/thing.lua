Thing = {}
Thing.__index = Thing

things = {}

function Thing:new(o)
   o = o or {}
   self.__index = self
   setmetatable(o, self)

   o.vx = o.vx or 0
   o.vy = o.vy or 0
   o.ox = o.ox or 0
   o.oy = o.oy or 0

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

function Thing:draw()
   love.graphics.draw(self.sprite,
		      self.x-self.ox,
		      self.y-self.oy)
--[[ local a = self.bb
   love.graphics.point(self.x-a, self.y-a)
   love.graphics.point(self.x+a, self.y+a)
   love.graphics.point(self.x-a, self.y+a)
   love.graphics.point(self.x+a, self.y-a) --]]
end

function Thing:update(dt)
   self.x = self.x + dt*self.vx
   self.y = self.y + dt*self.vy
end

function Thing:stop()
   self.vx = 0
   self.vy = 0
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
