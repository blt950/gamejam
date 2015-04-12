
clouds = {}

function clouds.load()


	love.window.setMode(1280,720)
	love.graphics.setBackgroundColor(80,219,255)
	
	img_cloud      = love.graphics.newImage("graphics/skies/cloud/cloud.png")
	img_rain_cloud = love.graphics.newImage("graphics/skies/cloud/raincloud.png")
	
	
	cloudScale = 0.4
	
	img_width = img_cloud:getWidth()
	cloudXpos = {-img_width,-img_width, -img_width,-img_width, -img_width}
	cloudYpos = {25,25,25,25,25}
	cloudSpeed = {1,1,1,1,1}
	--raining = {false, false, false, false, false}
	
	cloudTable = {0,0,0,0,0} --up to 5 clouds
	--0 = no cloud
	--1 = cloud
	--2 = rain cloud
	
	waitTimer = 15
	waitReset = 15 + math.random(0, 15)
	cloudCount = 0
	
	
	--rainChance = 10
	

end


local function deleteCloud(i)
	cloudTable[i] = 0
	cloudXpos[i] = -img_width
	cloudYpos[i] = 50
	cloudCount = cloudCount -1
	--raining[i] = false
end

local function updateCloud(i)
	if cloudTable[i] > 0 then
		cloudXpos[i] = cloudXpos[i] + cloudSpeed[i]
		
		if cloudXpos[i] > love.window.getWidth() + img_width then
			deleteCloud(i)
		end	
	end
end


local function spawnCloud()
	for i = 1, #cloudTable do
		if cloudTable[i] == 0 then
		
			
		
			cloudTable[i] = math.random(1,2)
			
			--if cloudTable[i] == 2 then
			--	if math.random(0,100) < rainChance then
			--		raining[i] = true
			--	end
			--end
			
			
			cloudYpos[i] = math.random(25, 100)
			cloudSpeed[i] = 1 + math.random(0, 1)
			
			break
		end
	end
end

function clouds.update(dt)
	waitTimer = waitTimer - 0.1
	
	if waitTimer < 0 then
	
		if cloudCount < 5 then
			spawnCloud()
			cloudCount = cloudCount + 1
		end
	
		
		waitTimer = waitReset
	end
	
	for i = 1, #cloudTable do
		updateCloud(i)
	end
end





function clouds.draw()

	for i = 1, #cloudTable do
	
		if cloudSpeed[i] < 2 then
				cloudScale = -0.3
			else
				cloudScale = 0.4
			end
	
		if cloudTable[i] == 1 then
			love.graphics.draw(img_cloud, cloudXpos[i], cloudYpos[i], 0, cloudScale, cloudScale)
		elseif cloudTable[i] == 2 then
			love.graphics.draw(img_rain_cloud, cloudXpos[i], cloudYpos[i], 0, cloudScale, cloudScale)
			
			--if (raining[i]) then
			--	love.graphics.setColor(255,255,255)
			--	love.graphics.print("RAIN CLOUD", cloudXpos[i], cloudYpos[i])
			
			--end
		end		
	end
end
