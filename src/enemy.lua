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

table.insert(updatehooks, newenemy)