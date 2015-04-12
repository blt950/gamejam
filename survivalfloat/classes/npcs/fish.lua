fish = class()

fish.image = love.graphics.newImage("graphics/npcs/fish.png")
local heigh = fish.image:getHeight()*0.3
local width = fish.image:getWidth()*0.3
--fish.grid = anim8.newGrid(width,height,width,height)

function fish:init()
	--spawn rett utenfor window
	
	self.decider = math.random(0,1)
	self.moveSpeed = math.random(1,2)*100
	self.height = fish.image:getHeight()*0.3
	self.width = fish.image:getWidth()*0.3
	self.isHooked = false

	if self.decider < 0.5 then
		self.x = 0 - self.width --starter på venstre side
	else 
		self.x = love.window.getWidth() --starter på høyre side
	end
 					   --410 is the the y under raft	  
	self.y = math.random(410 + self.height, love.window.getHeight() - self.height)
	
end


function fish:update(dt)

	if (hook.x < self.x+5 and hook.x > self.x-5) and (hook.y < self.y+5 and hook.y > self.y-10) and not hook.fishOnHook then
		self.isHooked = true
		hook.fishOnHook = true
	end

	if self.isHooked then
		if self.decider < 0.5 then
			self.x = (hook.x - self.width/1.5)
			self.y = (hook.y + hook.height/2)
		else
			self.x = (hook.x)
			self.y = (hook.y + hook.height/2)
		end
	else
		if self.decider < 0.5 then
			self.x = self.x + self.moveSpeed * dt
		else
			self.x = self.x - self.moveSpeed * dt
		end
	end
end


function fish:draw()

	if self.decider < 0.5 then
		--love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
		love.graphics.draw(fish.image, self.x+self.width, self.y, 0, -0.3, 0.3)
	else 
		--love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
		love.graphics.draw(fish.image, self.x, self.y, 0, 0.3, 0.3) --speil langs y-aksen?
	end

end




