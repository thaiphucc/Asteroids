local love=require "love"
function Asteroids(x,y,ast_size,level,debugging)
    debugging=debugging or false

    local ASTEROID_VERT= 90-- avg edges of the asteroids
    local ASTEROID_JAG= 0.5--Jaggedness (less rounds), it will effect the accuracy of the hitbpx
    local ASTERROID_SPEED=math.random(50)+(level*2)
    local vert =math.ceil(math.random(ASTEROID_VERT+1)+ASTEROID_VERT/2)
    local offset={}
    for i=1,vert+1 do
        -- NOTE: the math.random() * ASTEROID_JAG should be like that and NOT math.random(ASTEROID_JAG)
        -- because math.random returns an INTEGER and not a FLOAT (and we want a float)
        table.insert(offset, math.random() * ASTEROID_JAG * 2 + 1 - ASTEROID_JAG)
    end
    local vel=-1
    if math.random()<0 then 
        vel=1--create randomness of asteroids' velocity
    end
    return {
        x=x,
        y=y,
        x_vel=ASTERROID_SPEED*math.random()*vel,
        y_vel=ASTERROID_SPEED*math.random()*vel,
        radius=math.ceil(ast_size/2),
        angle=math.rad(math.random(math.pi)),
        vert=vert,
        offset=offset,
        draw=function (self ,faded)
            if faded then
                local opacity=0.2
            else local opacity=1
            end
            love.graphics.setColor(186 / 255, 189 / 255, 182 / 255, self.opacity)
            local points = {self.x + self.radius * self.offset[1] * math.cos(self.angle), self.y + self.radius * self.offset[1] * math.sin(self.angle)}

            for i = 1, self.vert - 1 do
                table.insert(points, self.x + self.radius * self.offset[i + 1] * math.cos(self.angle + i * math.pi * 2 / self.vert))
                table.insert(points, self.y + self.radius * self.offset[i + 1] * math.sin(self.angle + i * math.pi * 2 / self.vert))
            end
            love.graphics.polygon("line",points)

            if debugging then   
                love.graphics.setColor(1, 0, 0)
                
                love.graphics.circle("line", self.x, self.y, self.radius) -- the hitbox of the asteroid
            end
        end,
        move=function(self,dt)
        self.x=self.x+self.x_vel*dt
        self.y=self.y+self.y_vel*dt
        end,
    }
end
return Asteroids