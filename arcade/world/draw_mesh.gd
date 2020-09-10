extends Node


var grid_tools = preload("res://arcade/world/grid_tools.gd")

onready var block_ref = preload("res://arcade/world/block_references.gd").new(get_tree().get_root().get_node("Arcade").blocks)


## Objects that hold collision
var floor_collider

var vertex_heights = {}



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func generate_segment(segment):
	generate_floors(segment)
	#generate_walls(segment)

func generate_walls(tiles):
	var arr = []
	arr.resize(Mesh.ARRAY_MAX)

	# PoolVectorXXArrays for mesh construction.
	var verts = PoolVector3Array()
	var uvs = PoolVector2Array()
	var normals = PoolVector3Array()
	var indices = PoolIntArray()

	#######################################
	
	var wall_map = {}
	
	for tile in tiles:
		var tile_data = tiles[tile]
		var coords = tile
		
		var tile_verts = grid_tools.get_vert_coords(tile)
		if tile_data.pieces.find("north")  != -1:
			var vert_refs = {"BL":-1, "BR":-1, "TL":-1, "TR":-1}
			var wall_verts = {
				"BL":tile_verts.TL + Vector3(0,vertex_heights[coords].TL,0),
				"BR":tile_verts.TR + Vector3(0,vertex_heights[coords].TR,0),
			}
			wall_verts.TL = wall_verts.BL + Vector3(0,10,0)
			wall_verts.TR = wall_verts.BR + Vector3(0,10,0)
			
			var wall_normals = Vector3(0, 0, -1)
			
			for vert in vert_refs:
				vert_refs[vert] = verts.size()
				verts.append(wall_verts[vert])
				normals.append(wall_normals)
				uvs.append(block_ref.blocks.tiles.wall[tile_data.materials.wall][vert])
		
			indices.append(vert_refs.TL)
			indices.append(vert_refs.BL)
			indices.append(vert_refs.BR)
			
			indices.append(vert_refs.TL)
			indices.append(vert_refs.BR)
			indices.append(vert_refs.TR)
		if tile_data.pieces.find("south")  != -1:
			var vert_refs = {"BL":-1, "BR":-1, "TL":-1, "TR":-1}
			var wall_verts = {
				"BL":tile_verts.BL + Vector3(0,vertex_heights[coords].BL,0),
				"BR":tile_verts.BR + Vector3(0,vertex_heights[coords].BR,0),
			}
			wall_verts.TL = wall_verts.BL + Vector3(0,10,0)
			wall_verts.TR = wall_verts.BR + Vector3(0,10,0)
			
			var wall_normals = Vector3(0, 0, -1)
			
			for vert in vert_refs:
				vert_refs[vert] = verts.size()
				verts.append(wall_verts[vert])
				normals.append(wall_normals)
				uvs.append(block_ref.blocks.tiles.wall[tile_data.materials.wall][vert])
		
			indices.append(vert_refs.TL)
			indices.append(vert_refs.BR)
			indices.append(vert_refs.BL)
			
			indices.append(vert_refs.TL)
			indices.append(vert_refs.TR)
			indices.append(vert_refs.BR)
		if tile_data.pieces.find("east")  != -1:
			var vert_refs = {"BL":-1, "BR":-1, "TL":-1, "TR":-1}
			var wall_verts = {
				"BL":tile_verts.TL + Vector3(0,vertex_heights[coords].TL,0),
				"BR":tile_verts.BL + Vector3(0,vertex_heights[coords].BL,0),
			}
			wall_verts.TL = wall_verts.BL + Vector3(0,10,0)
			wall_verts.TR = wall_verts.BR + Vector3(0,10,0)
			
			var wall_normals = Vector3(0, 0, -1)
			
			for vert in vert_refs:
				vert_refs[vert] = verts.size()
				verts.append(wall_verts[vert])
				normals.append(wall_normals)
				uvs.append(block_ref.blocks.tiles.wall[tile_data.materials.wall][vert])
		
			indices.append(vert_refs.TL)
			indices.append(vert_refs.BR)
			indices.append(vert_refs.BL)
			
			indices.append(vert_refs.TL)
			indices.append(vert_refs.TR)
			indices.append(vert_refs.BR)
		if tile_data.pieces.find("west")  != -1:
			var vert_refs = {"BL":-1, "BR":-1, "TL":-1, "TR":-1}
			var wall_verts = {
				"BL":tile_verts.TR + Vector3(0,vertex_heights[coords].TR,0),
				"BR":tile_verts.BR + Vector3(0,vertex_heights[coords].BR,0),
			}
			wall_verts.TL = wall_verts.BL + Vector3(0,10,0)
			wall_verts.TR = wall_verts.BR + Vector3(0,10,0)
			
			var wall_normals = Vector3(0, 0, -1)
			
			for vert in vert_refs:
				vert_refs[vert] = verts.size()
				verts.append(wall_verts[vert])
				normals.append(wall_normals)
				uvs.append(block_ref.blocks.tiles.wall[tile_data.materials.wall][vert])
		
			indices.append(vert_refs.TL)
			indices.append(vert_refs.BL)
			indices.append(vert_refs.BR)
			
			indices.append(vert_refs.TL)
			indices.append(vert_refs.BR)	
			indices.append(vert_refs.TR)
	
	
	
	#######################################

	# Assign arrays to mesh array.
	arr[Mesh.ARRAY_VERTEX] = verts
	arr[Mesh.ARRAY_TEX_UV] = uvs
	arr[Mesh.ARRAY_NORMAL] = normals
	arr[Mesh.ARRAY_INDEX] = indices

	# Create mesh surface from mesh array.
	var new_map = MeshInstance.new()
	
	var new_mesh = ArrayMesh.new()
	
	new_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arr) # No blendshapes or compression used.	
	new_map.set_surface_material(0,preload("res://img/world.tres"))

func generate_floors(tiles):
	var arr = []
	arr.resize(Mesh.ARRAY_MAX)

	# PoolVectorXXArrays for mesh construction.
	var verts = PoolVector3Array()
	var uvs = PoolVector2Array()
	var normals = PoolVector3Array()
	var indices = PoolIntArray()

	#######################################

	for tile in tiles:
		var data = tiles[tile]
		var tile_data = {"TL":-1, "TR":-1, "BL":-1, "BR":-1}
		
		var coord = tile
		
		var tile_verts = grid_tools.get_vert_coords(tile)
		var tile_heights = {
			"TL":0,
			"TR":0,
			"BL":0,
			"BR":0
		}
		if(data.get('height') != null):
			tile_heights = calculate_y(tiles, coord)
		var tile_normals = {}
		vertex_heights[coord] = {}
		tile_verts.TL = tile_verts.TL + Vector3(0,tile_heights.TL,0)
		vertex_heights[coord].TL = tile_heights.TL
		tile_verts.TR = tile_verts.TR + Vector3(0,tile_heights.TR,0)
		vertex_heights[coord].TR = tile_heights.TR
		tile_verts.BL = tile_verts.BL + Vector3(0,tile_heights.BL,0)
		vertex_heights[coord].BL = tile_heights.BL
		tile_verts.BR = tile_verts.BR + Vector3(0,tile_heights.BR,0)
		vertex_heights[coord].BR = tile_heights.BR
		
		var side1
		var side2
		
		side2 = tile_verts.BL - tile_verts.TL
		side1 = tile_verts.TR - tile_verts.TL
		tile_normals.TL = side1.cross(side2).normalized()
		
		side2 = tile_verts.TL - tile_verts.TR
		side1 = tile_verts.BR - tile_verts.TR
		tile_normals.TR = side1.cross(side2).normalized()
		
		side2 = tile_verts.BR - tile_verts.BL
		side1 = tile_verts.TL - tile_verts.BL
		tile_normals.BL = side1.cross(side2).normalized()
		
		side2 = tile_verts.TR - tile_verts.BR
		side1 = tile_verts.BL - tile_verts.BR
		tile_normals.BR = side1.cross(side2).normalized()
				
		for vert in tile_data:
			tile_data[vert] = verts.size()
			verts.append(tile_verts[vert])
			normals.append(tile_normals[vert])
			uvs.append(block_ref.blocks.tiles.floor[data.materials.floor][vert])
		
		indices.append(tile_data.TL)
		indices.append(tile_data.BL)
		indices.append(tile_data.BR)
		
		indices.append(tile_data.TL)
		indices.append(tile_data.BR)
		indices.append(tile_data.TR)
		
	#######################################

	# Assign arrays to mesh array.
	arr[Mesh.ARRAY_VERTEX] = verts
	arr[Mesh.ARRAY_TEX_UV] = uvs
	arr[Mesh.ARRAY_NORMAL] = normals
	arr[Mesh.ARRAY_INDEX] = indices

	# Create mesh surface from mesh array.
	var new_map = MeshInstance.new()
	
	var new_mesh = ArrayMesh.new()
	new_map.mesh = new_mesh
	add_child(new_map)
	new_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arr) # No blendshapes or compression used.	
	new_map.set_surface_material(0,preload("res://img/world.tres"))
	
func generate_ceils():
	var arr = []
	arr.resize(Mesh.ARRAY_MAX)

	# PoolVectorXXArrays for mesh construction.
	var verts = PoolVector3Array()
	var uvs = PoolVector2Array()
	var normals = PoolVector3Array()
	var indices = PoolIntArray()

	#######################################

	

	#######################################

	# Assign arrays to mesh array.
	arr[Mesh.ARRAY_VERTEX] = verts
	arr[Mesh.ARRAY_TEX_UV] = uvs
	arr[Mesh.ARRAY_NORMAL] = normals
	arr[Mesh.ARRAY_INDEX] = indices

	# Create mesh surface from mesh array.
	var new_map = MeshInstance.instance()
	
	var new_mesh = ArrayMesh.new()

	new_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arr) # No blendshapes or compression used.	
	new_map.set_surface_material(0,preload("res://img/world.tres"))


func calculate_y(tileset, coord):
	var result = {
		"TL":0,
		"TR":0,
		"BL":0,
		"BR":0
	}
	
	var heights = []
	
	var avg1
	var avg2
	var avg3
	var avg4
	
	var total
	
	# TL
	avg1 = tileset.get(coord + Vector2(-1, 0))
	avg2 = tileset.get(coord)
	avg3 = tileset.get(coord + Vector2(-1, 1))
	avg4 = tileset.get(coord + Vector2(0,1))
	if avg1 != null:
		heights.push_back(avg1.height)
	if avg2 != null:
		heights.push_back(avg2.height)
	if avg3 != null:
		heights.push_back(avg3.height)
	if avg4 != null:
		heights.push_back(avg4.height)
	
	total = 0
	for height in heights:
		total = total + height
	result.TL = total / heights.size()
	heights.clear()
	
	#TR
	avg1 = tileset.get(coord + Vector2(1,0))
	avg2 = tileset.get(coord + Vector2(1,1))
	avg3 = tileset.get(coord + Vector2(0,1))
	avg4 = tileset.get(coord)
	if avg1 != null:
		heights.push_back(avg1.height)
	if avg2 != null:
		heights.push_back(avg2.height)
	if avg3 != null:
		heights.push_back(avg3.height)
	if avg4 != null:
		heights.push_back(avg4.height)

	total = 0
	for height in heights:
		total = total + height
	result.TR = total / heights.size()
	heights.clear()
	#BL
	avg1 = tileset.get(coord + Vector2(-1,0))
	avg2 = tileset.get(coord + Vector2(-1,-1))
	avg3 = tileset.get(coord + Vector2(0,-1))
	avg4 = tileset.get(coord)
	if avg1 != null:
		heights.push_back(avg1.height)
	if avg2 != null:
		heights.push_back(avg2.height)
	if avg3 != null:
		heights.push_back(avg3.height)
	if avg4 != null:
		heights.push_back(avg4.height)

	total = 0
	for height in heights:
		total = total + height
	result.BL = total / heights.size()
	heights.clear()
	
	#BR
	avg1 = tileset.get(coord + Vector2(1,0))
	avg2 = tileset.get(coord + Vector2(1,-1))
	avg3 = tileset.get(coord + Vector2(0,-1))
	avg4 = tileset.get(coord)	
	if avg1 != null:
		heights.push_back(avg1.height)
	if avg2 != null:
		heights.push_back(avg2.height)
	if avg3 != null:
		heights.push_back(avg3.height)
	if avg4 != null:
		heights.push_back(avg4.height)

	total = 0
	for height in heights:
		total = total + height
	result.BR = total / heights.size()
	heights.clear()	
	
	
	return result
