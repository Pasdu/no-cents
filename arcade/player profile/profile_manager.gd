extends Node


var manifest
var game_title

var loaded_profiles = {
	
}

# Called when the node enters the scene tree for the first time.
func _init(game_name):
	game_title = game_name

func get_profile(profile_name):
	var create = false
	
	var profile = {"global":null, "local":null}
	var global_profile = File.new()
	if not global_profile.file_exists("user://" + profile_name + ".save"):
		profile.global = {}
		create = true
	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	global_profile.open("user://" + profile_name + ".save", File.READ)
	profile.global = parse_json(global_profile.get_line())


	var local_profile = File.new()
	if not local_profile.file_exists("user://" + profile_name + "." +  game_title):
		profile.local = {}
		create = true
	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	local_profile.open("user://" + profile_name + "." +  game_title, File.READ)
	profile.local = parse_json(local_profile.get_line())


	loaded_profiles[profile_name] = profile
	
	if create:
		save_profile(profile_name)
		
func save_profile(profile_name):
	var global_profile = File.new()
	global_profile.open("user://" + profile_name + ".save", File.WRITE)
	
		# Store the save dictionary as a new line in the save file.
	global_profile.store_line(to_json(loaded_profiles[profile_name].global))
	global_profile.close()

	var local_profile = File.new()
	local_profile.open("user://" + profile_name + "." + game_title, File.WRITE)
	
		# Store the save dictionary as a new line in the save file.
	local_profile.store_line(to_json(loaded_profiles[profile_name].local))
	local_profile.close()

func save_manifest():
	var save_game = File.new()
	save_game.open("user://manifest.save", File.WRITE)
	
		# Store the save dictionary as a new line in the save file.
	save_game.store_line(to_json(manifest))
	save_game.close()
	

func load_manifest():
	var save_game = File.new()
	if not save_game.file_exists("user://manifest.save"):
		manifest = {"profiles":[]}
		save_manifest()
		return # Error! We don't have a save to load.
	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	save_game.open("user://manifest.save", File.READ)
	manifest = parse_json(save_game.get_line())
