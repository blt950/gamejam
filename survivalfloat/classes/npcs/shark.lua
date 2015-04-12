shark = class()

shark.image = love.graphics.newImage("graphics/npcs/shark.png")
--local height = fish.image:getHeight()*0.2
--local width = fish.image:getWidth()*0.2
--fish.grid = anim8.newGrid(width,height,width,height)

function shark:init()
	--spawn rett utenfor window
	
	self.scale = 0.7
	
	self.decider = math.random(0,1)
	self.moveSpeed = math.random(1,2)*100
	self.height = shark.image:getHeight()*self.scale
	self.width = shark.image:getWidth()*self.scale
	self.isHooked = false
	
	

	if self.decider < 0.5 then
		self.x = 0 - self.width --starter på venstre side
	else 
		self.x = love.window.getWidth() --starter på høyre side
	end
 					   --410 is the the y under raft
	self.y = math.random(410 + self.height, love.window.getHeight() - self.height)
	
end


function shark:update(dt)
	
	if self.decider < 0.5 then
		self.x = self.x + self.moveSpeed * dt
	else
		self.x = self.x - self.moveSpeed * dt
	end
	
end


function shark:draw()

	if self.decider < 0.5 then
		--love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
		love.graphics.draw(shark.image, self.x+self.width, self.y-self.height, 0, -self.scale, self.scale)
	else 
		--love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
		love.graphics.draw(shark.image, self.x, self.y-self.height, 0, self.scale, self.scale) --speil langs y-aksen?
	end

end




