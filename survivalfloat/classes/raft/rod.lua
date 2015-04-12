rod = {}

function rod.load()
	
	--ROD

	rod.image = love.graphics.newImage("graphics/raft/rod.png")
	rod.x = 780
	rod.y = 300
	rod.width = rod.image:getWidth()*0.5
	rod.hight = rod.image:getHeight()*0.5
	rod.inUse = false

	--HOOK

	hook = {}
	hook.image = love.graphics.newImage("graphics/raft/hook.png")
	hook.x = rod.x+rod.width-14
	hook.y = 350
	hook.width = hook.image:getWidth()*0.5
	hook.height = hook.image:getHeight()*0.5
	hook.speed = 200
	hook.fishOnHook = false


end

function rod.update(dt)

	playerAtRod()

	if rod.inUse then
		if love.keyboard.isDown("a") and not love.keyboard.isDown("d") and rod.inUse then
			hook.y = hook.y + (hook.speed * dt)
			if hook.y > (love.window.getHeight()-hook.height) then
				hook.y = (love.window.getHeight()-hook.height)
			end
		end
		if love.keyboard.isDown("d") and not love.keyboard.isDown("a") and rod.inUse then
			hook.y = hook.y - (hook.speed * dt)
			if hook.y < 350 then
				hook.y = 350
			end
		end
	end
end

function rod.draw()
	love.graphics.draw(rod.image, rod.x, rod.y, 0, 0.5, 0.5)
	love.graphics.draw(hook.image, hook.x, hook.y, 0, 0.5, 0.5)
	love.graphics.line(rod.x+rod.width, rod.y, hook.x+hook.width-4, hook.y)
end

function playerAtRod()
	if (player.X >= (753-10) and player.X <= 756) and (player.Y >= 364 and player.Y <= 367) then
		rod.inUse = true
	else
		rod.inUse = false
	end
end