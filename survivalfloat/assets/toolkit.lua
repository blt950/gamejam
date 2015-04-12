
--[[

~ ~ ~ TOOL KIT ~ ~ ~ 
Used to add own custom functions

]]--

function math.clamp(val, lower, upper)
    assert(val and lower and upper, "not very useful error message here")
    if lower > upper then lower, upper = upper, lower end -- swap if boundaries supplied the wrong way
    return math.max(lower, math.min(upper, val))
end

function isColliding(a,b)
	return not ((a.X > b.x + b.width) or (b.x > a.X + a.width) or (a.Y > b.y + b.height) or (b.y > a.Y + a.height))
end

function playerIsHit()
	if player.isHit then
		love.graphics.setColor(255, 0, 0, 100)
		love.graphics.rectangle("fill", 0, 0, love.window.getWidth(),love.window.getHeight())
		love.graphics.setColor(255, 255, 255, 255)
	end
end

function reSpawn()
	objects.player.body:setX(640)
	objects.player.body:setY(360)
	player.X = objects.player.body:getX()
	player.Y = objects.player.body:getY()
end
