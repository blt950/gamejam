
skies = {}

local time = 1.0
local speed = 0.025

local day = true
local cycle = 0

local starImage = love.graphics.newImage("graphics/skies/stars.png")
local starSpeed = 2
local starX = -1280
local starAlpha = 0

function skies.load()

	starAlpha = 0
	time = 1.0
	
end

function skies.update(dt)

	if day then
		time = time + speed * dt
		if time > 1 then day = false starX = -1280 end
	else
	    time = time - speed * dt
	    if time < 0 then day = true cycle=cycle+1 end
	end

	starX = starX + starSpeed * dt

	skyObjs.update(dt, skies.getTime(), skies.getSpeed())
	
	--spawn.setMaxFish(3)
	
	if cycle == 2 then
		spawn.setMaxFish(2)
	elseif cycle == 5 then
		spawn.setMaxFish(1)
	end
	
end


function skies.draw()

	love.graphics.setColor(178,232,255,255*time)
	love.graphics.rectangle("fill", 0, 0, love.window.getWidth(), love.window.getHeight())
	love.graphics.setColor(255,255,255, 255)

	local starAlpha = (255)*(-1*time*2+1)
	love.graphics.setColor(255,255,255, math.clamp(starAlpha, 0, 255))
	love.graphics.draw(starImage, starX, 0)
	love.graphics.setColor(255,255,255,255)

	--love.graphics.printf("Day:"..cycle, 10, 10, 100, 'left')
	--love.graphics.printf("Time:"..time, 150, 0, 100, 'left')

	skyObjs.draw()
end

function skies.getDay()
	return cycle
end

function skies.getTime()
	return time
end

function skies.getSpeed()
	return speed
end
