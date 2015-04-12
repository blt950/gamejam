
physics = {}
objects = {}

function physics.load()
	love.physics.setMeter(64)
	world = love.physics.newWorld(0, 9.81*64, true)
end


function physics.update(dt)
	world:update(dt)
end


function physics.draw()
	--love.graphics.polygon("fill", objects.raftRight.body:getWorldPoints(objects.raftRight.shape:getPoints()))
end