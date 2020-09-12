extends "res://arcade/arcade.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var map_maker = preload("res://arcade/world/map_from_image.gd")

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
func _ready():
	var map = map_maker.generate_map_from_image("res://img/world.png", null)
	var draw_mesh = get_node("world")
	draw_mesh.generate_segment(map)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
