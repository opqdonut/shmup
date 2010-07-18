EnemyBullet = {}
EnemyBullet.__index = EnemyBullet
setmetatable(EnemyBullet,Thing)

function EnemyBullet:collide(thing)
   if thing.type == "player" or thing.type == "bullet" then
      self:remove()
   end
end


Enemy = {}
Enemy.__index = Enemy
setmetatable(Enemy,Thing)

function Enemy:collide(thing)
   if thing.type == "bullet" or thing.type == "player" then
      self:remove()
   end
end

function Enemy:update(dt)
   Thing.update(self, dt)
   
   if math.random() < 0.995 then
      return
   end

   local shot = EnemyBullet:new {
      sprite = love.graphics.newImage("ebullet.png"),
      ox = 32, oy = 32,
      bb = 8,
      y = self.y,
      x = self.x,
      vx = 0,
      vy = 2*self.vy,
      type = "enemybullet"}
end

function newenemy()
   
   if math.random() < 0.95 then
      return
   end

   local enemy = Enemy:new {
      sprite = love.graphics.newImage("enemy1.png"),
      ox = 32, oy = 32,
      bb = 8,
      y = 0, x = math.random(love.graphics.getWidth()),
      vx = 0, vy = math.random(40,120),
      type = "enemy"}

end

table.insert(updatehooks, newenemy)