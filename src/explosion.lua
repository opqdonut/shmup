Particle = {
   type = "inert",
   sprite = love.graphics.newImage("particle.png")
}
Particle.__index = Particle
setmetatable(Particle,Thing)

FACTOR=0.99
BIAS=8

function Particle:update(dt)
   self.lifetime = self.lifetime - dt
   if self.lifetime < 0 then
      self:remove()
      return
   end

   self.vx = self.vx * FACTOR
   self.vy = self.vy * FACTOR

   Thing.update(self,dt)
end

LIFE=1

function explode(ox,oy,size)
   for i = 0,size*10 do
      Particle:new {
	 lifetime=LIFE+math.random(),
	 x=ox,
	 y=oy,
	 vx=math.random(200)-100,
	 vy=math.random(200)-100
      }
   end
end
   
   