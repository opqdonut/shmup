
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
   love.graphics.draw(self.sprite, self.x, self.y)
end

function Thing:update(dt)
   self.x = self.x + dt*self.vx
   self.y = self.y + dt*self.vy
end

function Thing:accel(dvx, dvy)
   self.vx = self.vx + dvx
   self.vy = self.vy + dvy
end

ship = Thing:new {sprite = love.graphics.newImage("ship.png"),
	          x = 100.0, y = 100.0}

things = {ship}

--

binds = {
   s = function () ship:accel(0,10) end,
   d = function () ship:accel(10,0) end,
   w = function () ship:accel(0,-10) end,
   a = function () ship:accel(-10,0) end,

   down = function () ship:accel(0,10) end,
   right = function () ship:accel(10,0) end,
   up = function () ship:accel(0,-10) end,
   left = function () ship:accel(-10,0) end,
}

--

function love.update(dt)

   for key, action in pairs(binds) do
      if love.keyboard.isDown(key) then
	 print("event", key)
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

