function newenemy()
   
   if math.random() < 0.99 then
      return
   end

   local enemy = Thing:new {
      sprite = love.graphics.newImage("enemy1.png"),
      ox = 32, oy = 32,
      bb = 8,
      y = 0, x = math.random(love.graphics.getWidth()),
      vx = 0, vy = math.random(40,120),
      type = "enemy"}

   function enemy:collide(thing)
      if thing.type == "bullet" then
	 self:remove()
      end
   end
end

table.insert(updatehooks, newenemy)