spawn = {}

function spawn.load()

	-- Load for fishes
	fishes = {} 
	fishes.counter = 0
	fishes.timer = 0
	fishes.table = {}
	
	maxFish = 3

	--Load for sharks
	sharks = {}
	sharks.counter = 0
	sharks.timer = 0
	sharks.table = {}

end

function spawn.update(dt)
	
	updateFish(dt)
	updateSharks(dt)

end

function spawn.draw()

	-- Fishes
	for i,v in ipairs(fishes.table) do
		v:draw()
	end

	for i,v in ipairs(sharks.table) do
		v:draw()
	end

	--love.graphics.printf("Fishes: "..#fishes.table, 200, 30, 100, 'left')
	--love.graphics.printf("Sharks: "..#sharks.table, 300, 30, 100, 'left')
	--love.graphics.printf("hook.y:"..hook.y, 400, 30, 100, 'left')

end	


function spawn.setMaxFish(max)
	maxFish = max
end



-- Updating the fishes
function updateFish(dt)

	fishes.timer = (fishes.timer + dt)

	if fishes.timer > maxFish then
		fishes.timer = (fishes.timer - 3)
		if fishes.counter < 3 then
			local f = fish:new()
			table.insert(fishes.table, f)
			fishes.counter = (fishes.counter + 1)
		end	
	end

	for i,v in ipairs(fishes.table) do
		v:update(dt)
		if v.x < 0-v.width and v.decider > 0.5 or v.x > love.window.getWidth() and v.decider < 0.5 then
			table.remove(fishes.table, i)
			fishes.counter = (fishes.counter - 1)
		end
		if hook.y == 350 and v.isHooked then
			table.remove(fishes.table, i)
			fishes.counter = (fishes.counter - 1)
			hook.fishOnHook = false
			HUD.increaseFood()
			HUD.increaseFood()
			HUD.addFishEaten()
		end
	end
end

--Updating the sharks
function updateSharks(dt)

	sharks.timer = (sharks.timer + dt)

	if sharks.timer > 3 then
		sharks.timer = (sharks.timer - 3)
		if sharks.counter < 5 then
			local s = shark:new()
			table.insert(sharks.table, s)
			sharks.counter = (sharks.counter + 1)
		end
	end

	for i,v in ipairs(sharks.table) do
		v:update(dt)
		if v.x < 0-v.width and v.decider >= 0.5 or v.x > love.window.getWidth() and v.decider <= 0.5 then
			table.remove(sharks.table, i)
			sharks.counter = (sharks.counter - 1)
		end
	end
end
