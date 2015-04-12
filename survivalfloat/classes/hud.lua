

HUD = {}
HUD.showMenu = 0

font = love.graphics.newFont("graphics/fonts/seagull_wine.ttf", 42)


function HUD.load()
	love.graphics.setBackgroundColor(80,219,255)
	love.window.setMode(1280,720)

	
	--font = love.graphics.newFont(24)
	love.graphics.setFont(font)
	
	--Food

	
	img_food_empty = love.graphics.newImage("graphics/hud/chicken bone/chicken-bone-empty.png")
	img_food_half  = love.graphics.newImage("graphics/hud/chicken bone/chicken-bone-half.png")
	img_food_full  = love.graphics.newImage("graphics/hud/chicken bone/chicken-bone-full.png")
	
	foodXpos = love.window.getWidth() - 240
	foodYpos = 80
	
	
	foodTimerReset = 200
	foodTimer = foodTimerReset
	
	foodTimer2Reset = foodTimerReset
	foodTimer2 = foodTimer2Reset
	
	food = 6
	foodTable = {2,2,2} --alle tre er fulle
	--2 = draw full
	--1 == draw half
	--0 == draw empty
	
	
	--Food end
	
	hungerTimerReset = 300
	hungerTimer = hungerTimerReset
	
	fishEaten = 0
	
	--Health
	img_health_empty = love.graphics.newImage("graphics/hud/heart/heart-empty.png")
	img_health_half = love.graphics.newImage("graphics/hud/heart/heart-half.png")
	img_health_full = love.graphics.newImage("graphics/hud/heart/heart-full.png")
	
	healthXpos = love.window.getWidth() - 240
	healthYpos = 20
	health = 6
	
	
	healthTable = {2,2,2}
	--Health end

	started = false
end


local function drawChickenBone(i, index)
	if i == 0 then
		love.graphics.draw(img_food_empty, foodXpos + (index * img_food_empty:getWidth() * 0.1), foodYpos, 0, 0.1, 0.1)
	elseif i == 1 then
		love.graphics.draw(img_food_half, foodXpos + (index * img_food_half:getWidth() * 0.1), foodYpos, 0, 0.1, 0.1)
	elseif i == 2 then
		love.graphics.draw(img_food_full, foodXpos + (index * img_food_full:getWidth() * 0.1), foodYpos, 0, 0.1, 0.1)
	end
end

local function drawFood()
	for i = 1, 3 do
		drawChickenBone(foodTable[i], i)
	end
end

local function drawHeart(i, index)
	if i == 0 then
		love.graphics.draw(img_health_empty, healthXpos + (index * img_health_empty:getWidth() * 0.1), healthYpos, 0, 0.1, 0.1)
	elseif i == 1 then
		love.graphics.draw(img_health_half, healthXpos + (index * img_health_half:getWidth() * 0.1), healthYpos, 0, 0.1, 0.1)	
	elseif i == 2 then
		love.graphics.draw(img_health_full, healthXpos + (index * img_health_full:getWidth() * 0.1), healthYpos, 0, 0.1, 0.1)
	end
end

local function drawHealth()
	for i = 1, 3 do
		drawHeart(healthTable[i], i)
	end
end


local function reduceTable(table)
	for i = #table, 1, -1 do
		if table[i] > 0 then
			table[i] = table[i] - 1
			break
		end
	end
end


local function increaseTable(table)
	for i = 1, #table do
		if table[i] < 2 then
			table[i] = table[i] + 1
			break
		end
	end
end





function HUD.draw()

	if HUD.showMenu == 1 then

		love.graphics.setColor(50, 50, 50, 200)
		love.graphics.rectangle("fill", 0, 0, love.window.getWidth(),love.window.getHeight())
		love.graphics.setColor(255, 255, 255, 255)

		local titleFont = love.graphics.newFont("graphics/fonts/seagull_wine.ttf", 128)
		love.graphics.setFont(titleFont)
		love.graphics.printf("Survival Float", 1280/2-(200/2), 720/2-150, 200, "center")

		love.graphics.setFont(font)
		love.graphics.printf("Press 'space' to start the game", (1280/2)-(1000/2), (720/2)+300, 1000, "center")

		local creditsFont = love.graphics.newFont("graphics/fonts/seagull_wine.ttf", 14)
		love.graphics.setFont(creditsFont)
		love.graphics.printf("Development and Graphics: Daniel Lange, Henning Parratt Tandberg, Torstein Breivig", 10, 10, 1000, "left")
		love.graphics.printf("Music by: Ton at jamendo.com", 10, 30, 1000, "left")


		love.graphics.setFont(font)


	elseif player.alive then

		love.graphics.setColor(255,255,255)

		drawFood()
		drawHealth()
		love.graphics.print("Days: "..skies.getDay(), 10, 30)
		love.graphics.print("Score: "..fishEaten, 10, 70)

	end
	
	if not player.alive then

		love.graphics.setColor(50, 50, 50, 200)
		love.graphics.rectangle("fill", 0, 0, love.window.getWidth(),love.window.getHeight())
		love.graphics.setColor(255, 255, 255, 255)

		local titleFont = love.graphics.newFont("graphics/fonts/seagull_wine.ttf", 128)
		love.graphics.setFont(titleFont)
		love.graphics.printf("You died!", 1280/2-(200/2), 720/2-150, 200, "center")

		love.graphics.setFont(font)
		love.graphics.printf("Score: "..fishEaten*skies.getDay(), (1280/2)-(1000/2), (720/2)+100, 1000, "center")
		love.graphics.printf("Press 'space' to start new game", (1280/2)-(1000/2), (720/2)+300, 1000, "center")

	end

	

	--love.graphics.printf("FPS: "..love.timer.getFPS(), 0, 0, 100, 'left')	
	
end

function HUD.update(dt)

	if love.keyboard.isDown(" ") and HUD.showMenu > 0 then
		HUD.showMenu = 0
		started = true
		audio.menuMusic:stop()
		audio.music:play()
	end

	if love.keyboard.isDown(" ") and not player.alive then
		
		audio.menuMusic:stop()
		audio.music:stop()

		HUD.showMenu = 0
		love.load()
	end

	--[[if (skies.getTime() < 0) then
		HUD.reduceFood()
	elseif (skies.getTime() > 1) then
		HUD.reduceFood()
	end]]--
	
	
	hungerTimer = hungerTimer - 50*dt
	
	if hungerTimer < 0 then
		HUD.reduceFood()
		hungerTimer = hungerTimerReset
	end
	
	
	
	if food == 6 then
		foodTimer = foodTimer - 100*dt
		
		if foodTimer < 0 then
			HUD.increaseHealth()
			foodTimer = foodTimerReset
		end
		
	else
		foodTimer = foodTimerReset
	end
	
	
	if food == 0 then
		foodTimer2 = foodTimer2 -1
		
		if foodTimer2 == 0 then
			HUD.reduceHealth()
			foodTimer2 = foodTimer2Reset
		end
	else
		foodTimer2 = foodTimer2Reset
	end
	
	
	
	-- Kill the player
	if health == 0 then
		player.alive = false
	end	
	
end

function HUD.addFishEaten()
	fishEaten = fishEaten + 1
end


function HUD.reduceFood()
	reduceTable(foodTable)
	if food > 0 then
		food = food - 1
	end
end

function HUD.increaseFood()
	increaseTable(foodTable)
	hungerTimer = hungerTimerReset
	if food < 6 then
		food = food + 1
	end
	
end

function HUD.reduceHealth()
	reduceTable(healthTable)
	if health > 0 then
		health = health - 1
	end
end

function HUD.increaseHealth()
	increaseTable(healthTable)
	
	if health < 6 then
		health = health + 1
	end
end
