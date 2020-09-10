extends Node

static func generate_map_from_image(image, height):
	var pallette = {
	"00cd00":"grass",
	"9c6b35":"dirty grass",
	"ff0022":"lava", ## building
	"572f2c":"hypno", ## Volcanic Rock
	"740016":"hypno", ## Dark Lava
	"0a6e0b":"hypno", ## forest
	"603a22":"hypno", ## dirt
	"46463a":"hypno", ## rock
	}
	
	var tile_image = load(image).get_data()
	var height_image
	
	
	if(height != null):
	 height_image = load(height).get_data()
	
	tile_image.lock()
	if(height != null):
		height_image.lock()
	
	var map = {}
	
	for y in range(tile_image.get_height()):
		for x in range(tile_image.get_width()):
			var tile_type = pallette[ tile_image.get_pixel(x, y).to_html(false) ]
			if height != null:
				var tile_height = pow(100, height_image.get_pixel(x,y).r * 1.2)
			
			var tile = {
				"materials":{"floor":tile_type},
				"pieces":[]
			}
			
			
			
			map[Vector2(x,y)] = tile
			
	return map
