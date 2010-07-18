Star = {}
Star.__index = Star
setmetatable(Star, Thing)

--[[
function Star:new(x,y,vy)
   local o = Thing.new {
      x=x,
      y=y,
      vy=vy,
      sprite=love.graphics.newImage("star.png"),
      type="star",
   }

   return o
end
--]]

function Star:outside()
   self.y = -math.random(30)
   self.x = math.random(love.graphics.getWidth())
end

function stars(step,v)
   for y = 0,love.graphics.getHeight(),step do
      Star:new {
	 x=math.random(love.graphics.getWidth()),
	 y=y,
	 vy=v,
	 sprite=love.graphics.newImage("star.png"),
	 type="star",
      }
   end
end

stars(20,211)
stars(30,292)
stars(40,383)