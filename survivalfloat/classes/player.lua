
player = {}

function player.load()

	--PLAYER IMAGES

	--player.standImg = love.graphics.newImage() 
	player.walkImage = love.graphics.newImage("graphics/player/walking.png")
	player.jumpImage = love.graphics.newImage("graphics/player/jump.png")

	--PLAYER ANIMATIONS

	player.image = love.graphics.newImage("graphics/player/stand.png")

	player.X = 640
	player.Y = 360
	player.baseY = 360

	player.scale = 4
	player.width = player.image:getWidth()/player.scale
	player.height = player.image:getHeight()/player.scale

	local grid = anim8.newGrid(player.image:getWidth(), player.image:getHeight(), player.walkImage:getWidth(), player.walkImage:getHeight())
	player.walkAnimation = anim8.newAnimation(grid('1-4',1), 0.1)

	player.diretion = "right"
	player.status = "stand"
	player.lives = 10.0

	player.isHit = false
	player.wasHit = player.isHit
	player.alive = true
	player.startPos = 0
	player.jumpings = false


	-- Creating physics object of the player
	objects.player = {}
	objects.player.body = love.physics.newBody(world, player.X, player.Y, "dynamic")
	objects.player.shape = love.physics.newRectangleShape(player.width, player.height)
	objects.player.fixture = love.physics.newFixture(objects.player.body, objects.player.shape, 0.45)
	
	objects.player.fixture:setRestitution(0.4)
	objects.player.body:setFixedRotation(true)

	-- Create map boundries
	objects.leftBox = {}
	objects.leftBox.body = love.physics.newBody(world, -1, -1, "static")
	objects.leftBox.shape = love.physics.newRectangleShape(1,love.window.getHeight()*2)
	objects.leftBox.fixture = love.physics.newFixture(objects.leftBox.body, objects.leftBox.shape)

	objects.rightBox = {}
	objects.rightBox.body = love.physics.newBody(world, love.window.getWidth(), 0, "static")
	objects.rightBox.shape = love.physics.newRectangleShape(1,love.window.getHeight()*2)
	objects.rightBox.fixture = love.physics.newFixture(objects.rightBox.body, objects.rightBox.shape)

	objects.bottomBox = {}
	objects.bottomBox.body = love.physics.newBody(world, 0, love.window.getHeight(), "static")
	objects.bottomBox.shape = love.physics.newRectangleShape(love.window.getWidth()*2,0)
	objects.bottomBox.fixture = love.physics.newFixture(objects.bottomBox.body, objects.bottomBox.shape)

end


function player.update(dt)

	player.X = objects.player.body:getX()
	player.Y = objects.player.body:getY()

	player.status = "stand"
	xVel,yVel = objects.player.body:getLinearVelocity()
	
	xVelMax = 150
	yVelMax = 100
	
	-- Keyboard Events
	
	if  not (xVel < -xVelMax) then
		if love.keyboard.isDown("left") then
			player.status = "walk"
			player.walkAnimation:update(dt)
			if objects.player.body:getY() > raft.Y - 25 then
				objects.player.body:applyForce(-200,0)
			end
		end	
	end
	
	

	if not (xVel > xVelMax) then 
		if love.keyboard.isDown("right") then
			player.status = "walk"
			player.walkAnimation:update(dt)
			if objects.player.body:getY() > raft.Y - 25 then
				objects.player.body:applyForce(200,0)
			end
		end
	end
	

	player.jumping()
	
	
	if love.keyboard.isDown("down") then
		objects.player.body:applyForce(0, 200)
	end

		
	-- Set player shape if under water or not
	if (objects.player.body:getY() > raft.Y + raft.delta) then

		objects.player.body:applyForce(0, -220)
		--objects.player.shape = love.physics.newRectangleShape(40,25)

	else
		--objects.player.body:applyForce(0, -300)

		--objects.player.shape = love.physics.newRectangleShape(25,40)

	end
	
	-- Force control if high up
	if (objects.player.body:getY() > raft.Y + raft.delta + 300) then
		objects.player.body:applyForce(0, -300)
	end
	
	if ((objects.player.body:getY() < raft.Y + raft.delta) and ((objects.player.body:getX() < raft.X - 300) or (objects.player.body:getX() > raft.X + 300)))  then
		if(yVel < 0) then
			objects.player.body:setLinearVelocity(xVel, 0.1 * yVel)
		end
	end

	player.isHit = false
	
	for i,v in ipairs(sharks.table) do
		if isColliding(player,v) then 
			player.isHit = true 
		end
	end
	
	if player.wasHit == false and player.isHit == true then
		audio.hit:play()
		HUD.reduceHealth()
		HUD.reduceHealth()
		
		--reSpawn()
	end
	
	player.wasHit = player.isHit

end


function player.draw()
	if player.status == "stand" then
		--love.graphics.rectangle("fill",player.X - player.width/2, player.Y - player.height/2, player.width, player.height)
		love.graphics.draw(player.image, objects.player.body:getX(), objects.player.body:getY(), 0, (1/player.scale), (1/player.scale), player.image:getWidth()/2, player.image:getHeight()/2)
	elseif player.status == "walk" then
		player.walkAnimation:draw(player.walkImage, objects.player.body:getX(), objects.player.body:getY(), 0, (1/player.scale), (1/player.scale), player.image:getWidth()/2, player.image:getHeight()/2)
	elseif player.status == "jumping" or player.status == "falling" then
		love.graphics.draw(player.jumpImage, objects.player.body:getX(), objects.player.body:getY(), 0, (1/player.scale), (1/player.scale), player.image:getWidth()/2, player.image:getHeight()/2)
	end
	--love.graphics.printf("X:"..player.X, 10, 100, 100, 'left')
	--love.graphics.printf("Y:"..player.Y, 10, 150, 100, 'left')
end


function player.jumping()
	
	if player.Y <= player.startPos - 10 then
		player.jumpings = false
		player.status = "falling"
	elseif player.jumpings == true then
		objects.player.body:applyForce(0,-500)
		
		player.status = "jumping"
	elseif player.Y >= player.startPos then
	end
	--[[if player.Y >= player.startPos then
		player.jumpings = false
	end]]--
end

function player.jump() 
	if player.jumpings == false then
		
		if player.Y < raft.Y + raft.delta then
			audio.jump:play()
		end
		player.status = "jumping"
		player.startPos = player.Y
		player.jumpings = true
	end
end
