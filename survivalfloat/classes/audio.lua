
audio = {}

function audio.load()
	audio.music = love.audio.newSource("sounds/music/ondina.mp3")
	audio.music:setLooping(true)

	audio.menuMusic = love.audio.newSource("sounds/music/watery.mp3")
	audio.menuMusic:setLooping(true)

	audio.splash = love.audio.newSource("sounds/splash.mp3")
	audio.hit = love.audio.newSource("sounds/hit.wav")
	audio.jump = love.audio.newSource("sounds/jump.wav")
end



--brukes:
--splash:play()