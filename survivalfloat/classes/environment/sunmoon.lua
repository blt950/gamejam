skyObjs = {}
sun = {}
moon = {}
curve = {}

sunImage = love.graphics.newImage("graphics/skies/sun.png")
moonImage = love.graphics.newImage("graphics/skies/moon.png")

function skyObjs.load()

	curve.a = 0.0
	curve.r = 680
	curve.speed = 0.3141592/(0.1/skies.getSpeed())
	curve.x = 1280/2
	curve.y = 720

	moon.r = 50
	moon.x = -500
	moon.y = -500

	sun.r = 50
	sun.x = -500
	sun.y = -500
	
end

function skyObjs.update(dt, time, speed)

	if curve.r <= 400 then
		curve.r = curve.r + 15
		if curve.r >= 680 then
			curve.r = 680
			curve.mid = true
		end
	elseif curve.r >= 680 then
		curve.r = curve.r - 15
		if curve.r <= 400 then
			curve.r = 400
			curve.mid = true
		end
	end

	curve.a = curve.a + curve.speed * dt

	sun.x = curve.x - curve.r * math.sin(curve.a)
	sun.y = curve.y - curve.r * math.cos(curve.a)
	moon.x = curve.y + curve.r * math.sin(curve.a)
	moon.y = curve.y + curve.r * math.cos(curve.a)
	
	if curve.a == 1 then
		curve.a = 0
	end

end

function skyObjs.draw()
	
	love.graphics.draw(sunImage, sun.x, sun.y, 0, 0.20, 0.20, sunImage:getWidth()/2, sunImage:getHeight()/2)
	love.graphics.draw(moonImage, moon.x, moon.y, 0, 0.18, 0.18, moonImage:getWidth(), moonImage:getHeight()/2)
	
end