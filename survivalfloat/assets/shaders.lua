
shaders = {}

function shaders.load()

	shader = love.graphics.newShader[[
		extern number intensity;
		vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords){
			
			vec4 pixel = Texel(texture, texture_coords);
			
			pixel.r = pixel.r * intensity;
			pixel.g = pixel.g * intensity;
			pixel.b = pixel.b * intensity;
			
			return pixel;
		}
	]]

	updown = false
	intensity = 0.5
	
end



function shaders.update(dt)

	intensity = math.clamp(skies.getTime(), 0.5, 1)

end