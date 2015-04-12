
sea = {}

local waves = {

	backWave = {
		image = love.graphics.newImage("graphics/sea/back.png"),
		x1 = -1280,
		x2 = 0,
		y = 0,
		speed = 6, --3.5

		up = true,
		upSpeed = 3, --2.5
		startPos = 0,
		delta = 5
	},

	middleWave = {
		image = love.graphics.newImage("graphics/sea/middle.png"),
		x1 = -1280,
		x2 = 0,
		y = 0,
		speed = 7.5, --6.5

		up = true,
		upSpeed = 2.5, --2
		startPos = 0,
		delta = 8
	},

	frontWave = {
		image = love.graphics.newImage("graphics/sea/front.png"),
		x1 = -1280,
		x2 = 0,
		y = 0,
		speed = 9.5, --8.5

		up = true,
		upSpeed = 1.5, --1.5
		startPos = 0,
		delta = 5
	}

}


function sea.update(dt)

	for k,v in pairs(waves) do
			
		-- Vertical wave moving

		v.x1 = v.x1 + v.speed * dt
		v.x2 = v.x2 + v.speed * dt

		if v.x1 > love.window.getWidth() then
			v.x1 = -love.window.getWidth()
		end

		if v.x2 > love.window.getWidth() then
			v.x2 = -love.window.getWidth()
		end

		-- Horizontal wave moving

		if v.up then
			v.y = v.y - v.upSpeed * dt
		else
			v.y = v.y + v.upSpeed * dt
		end

		if v.y < v.startPos then
			v.up = false
		end
		
		if v.y > v.startPos + v.delta then
			v.up = true
		end

	end
	
end


function sea.draw()

	love.graphics.draw(waves.backWave.image, waves.backWave.x1, waves.backWave.y)
	love.graphics.draw(waves.backWave.image, waves.backWave.x2, waves.backWave.y)

	love.graphics.draw(waves.middleWave.image, waves.middleWave.x1, waves.middleWave.y)
	love.graphics.draw(waves.middleWave.image, waves.middleWave.x2, waves.middleWave.y)

	love.graphics.draw(waves.frontWave.image, waves.frontWave.x1, waves.frontWave.y)
	love.graphics.draw(waves.frontWave.image, waves.frontWave.x2, waves.frontWave.y)

end
