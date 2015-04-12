
raft = {}

local raftImage = love.graphics.newImage("graphics/raft/raft.png")

function raft.load()

	raft.X = 640
	raft.Y = 320
	raft.delta = 88

	-- Crafting the raft floor
	objects.raft = {}
	objects.raft.body = love.physics.newBody(world, raft.X, raft.Y + raft.delta, "static")
	objects.raft.shape = love.physics.newRectangleShape(300,20)
	objects.raft.fixture = love.physics.newFixture(objects.raft.body, objects.raft.shape)

	-- Crafting the raft left side
	objects.raftLeft = {}
	objects.raftLeft.body = love.physics.newBody(world, raft.X - 140, raft.Y + raft.delta - 20, "static")
	objects.raftLeft.shape = love.physics.newRectangleShape(15, 20)
	objects.raftLeft.fixture = love.physics.newFixture(objects.raftLeft.body, objects.raftLeft.shape)

	-- Crafting the raft right side
	objects.raftRight = {}
	objects.raftRight.body = love.physics.newBody(world, raft.X + 140, raft.Y + raft.delta - 20, "static")
	objects.raftRight.shape = love.physics.newRectangleShape(15, 20)
	objects.raftRight.fixture = love.physics.newFixture(objects.raftRight.body, objects.raftLeft.shape)

end

function raft.update(dt)

end

function raft.draw()
	love.graphics.draw(raftImage, 640, 320, 0, 1, 1, raftImage:getWidth()/2, raftImage:getHeight()/2)
end