extends Node

static func world_to_grid(world):
	if(world.z != null):
		return Vector2(floor(world.x/10), floor(world.z/10))
	else:
		return Vector2(floor(world.x/10), floor(world.y/10))

static func grid_to_world(grid):
	return(Vector3(grid.x*10,0, grid.y*10))

static func grid_to_world_center(grid):
	return(Vector3((grid.x*10) + 5,0, (grid.y*10) + 5))

static func get_vert_coords(tile_coords):
	var world_coords = grid_to_world(tile_coords)
	
	var result = {
		"BL":world_coords,
		"BR":Vector3(10,0,0) + world_coords,
		"TL":Vector3(0,0,10) + world_coords,
		"TR":Vector3(10,0,10) + world_coords
	}
	
	return result
