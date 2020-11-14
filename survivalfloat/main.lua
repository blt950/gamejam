--[[

~ ~ ~ SURVIVAL FLOAT ~ ~ ~
by: Daniel, Henning Parratt Tandberg and Torstein Breivig

]]--




local created = false

function love.load(arg)
	
	-- Window configuration
	love.window.setMode(1280,720)
	love.window.setTitle("Survival Float")

	if not created then
		-- Import the physics init
		require("physics") physics.load()

		-- Import the required libaries
		anim8 = require("assets/anim8")
		require("assets/class")
		require("assets/toolkit")
		require("assets/shaders") shaders.load()

		-- Import our classes
		require("classes/player") player.load()
		require("classes/environment/skies") skies.load()
		require("classes/environment/sunmoon") skyObjs.load()
		require("classes/environment/clouds") clouds.load()
		require("classes/environment/sea")
		require("classes/raft/rod") rod.load()
		require("classes/raft/raft") raft.load()
		require("classes/hud") HUD.load()
		require("classes/npcs/fish")
		require("classes/npcs/shark")
		require("classes/spawn") spawn.load()
		require("classes/audio") audio.load()

		HUD.showMenu = 1

		created = true

	else

		physics.load()
		shaders.load()
		player.load()
		skies.load()
		skyObjs.load()
		clouds.load()
		rod.load()
		raft.load()
		HUD.load()
		spawn.load()
		audio.load()

	end

	audio.music:stop()
	audio.menuMusic:play()

end


function love.update(dt)

	if HUD.showMenu == 0 and player.alive then 
		physics.update(dt)
		shaders.update(dt)
		skies.update(dt)
		clouds.update(dt)
		sea.update(dt)
		raft.update(dt)
		player.update(dt)
		spawn.update(dt)
		rod.update(dt)
	end

	HUD.update(dt)
end
	

function love.draw()
	skies.draw()


	shader:send("intensity", intensity)
	love.graphics.setShader(shader)
		sea.draw()
		raft.draw()
		player.draw()
		clouds.draw()
		rod.draw()
		spawn.draw()
	love.graphics.setShader()

	physics.draw()
	playerIsHit()
	HUD.draw()

	--love.graphics.rectangle("fill",player.X - player.width/2, player.Y - player.height/2, player.width, player.height)	

end

function love.keypressed(key)
	if key == "escape" then love.event.push("quit") end
	if key == "up" then player.jump(key) end
end
