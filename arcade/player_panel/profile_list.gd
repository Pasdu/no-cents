extends Node

var selection = -1

onready var up_label = get_node("last")
onready var down_label = get_node("next")
onready var this_label = get_node("selected")

onready var profile_manager = get_tree().get_root().get_node("Arcade").profile_manager

func get_selection():
	if selection == -1:
		return -1
	else:
		return profile_manager.loaded_profiles.keys()[selection]
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func select_next():
	if selection +1 < profile_manager.loaded_profiles.keys().size():
		selection = selection + 1
		update_labels()

func select_last():
	if selection > - 1:
		selection = selection - 1
		update_labels()
	
func update_labels():
	var keys = profile_manager.loaded_profiles.keys()
	
	if selection >= 0 && selection < keys.size() :
		this_label.text = keys[selection]
		
	if selection == 0:
		up_label.text = "create new"
	elif selection == -1:
		up_label.text = ""
		this_label.text = "create new"
	else:
		up_label.text = keys[selection-1]
	
	if selection == keys.size() - 1:
		down_label.text = ""
	else:
		down_label.text = keys[selection+1]

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
