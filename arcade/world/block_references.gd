extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const blocks = {
	
	"materials":{
		"floor":{"width":32.0 , "height":32.0 , "x_tiles":2.0 , "y_tiles":2.0 },
		"ceiling":{"width":160.0, "height":160.0 ,  "x_tiles":5.0, "y_tiles":6.0 },
		"wall":{"width":160.0, "height":160.0, "x_tiles":5.0, "y_tiles":6.0}
	},
	"tiles":{
		"floor":{
			"lava":{},
			"grass":{},
			"dirty grass":{},
			"hypno":{},
			"volcanic rock":{},
		},
		"wall":{
			"brick":{},
			"blue_cement":{},
			"garage_door":{},
			"rusted_fence":{}
		}
	}
}

# Called when the node enters the scene tree for the first time.
func _init( block ):
	var boxSize
	var u = 0.0
	var v = 0.0
	for tile_set in blocks.tiles:
		var mat = blocks.materials[tile_set]
		boxSize = {"u":1.0/mat.x_tiles, "v":1.0/mat.y_tiles} 
		var i = 0
		for tile in block.tiles[tile_set]:
			var x = i % int(mat.x_tiles)
			var y = floor(i / mat.x_tiles)
			
			u = x * boxSize.u
			v = y * boxSize.v
			
			blocks.tiles[tile_set][tile].TL = Vector2(u+0.001, v + 0.001)
			blocks.tiles[tile_set][tile].TR = Vector2(u+boxSize.u - 0.001, v + 0.001)
			blocks.tiles[tile_set][tile].BL = Vector2(u+0.001, v + boxSize.v - 0.001)
			blocks.tiles[tile_set][tile].BR = Vector2(u + boxSize.u - 0.001, v + boxSize.v - 0.001)
			i = i + 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
