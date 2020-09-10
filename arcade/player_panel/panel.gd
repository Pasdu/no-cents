extends Node

onready var start_message = get_node("no player")
onready var profile_list = get_node("profile_list")
onready var create_interface = get_node("create profile")

var mode = 0

var MODES = {
	"UNUSED":0,
	"SELECT":1,
	"CREATE":2
}

func _handle_input(input, event):
	match mode:
		MODES.SELECT:
			if(input == "up" && event == "down"):
				profile_list.select_last()
			elif(input == "down" && event == "down"):
				profile_list.select_next()
			elif (input == "start" || input == 'a') && event == "down":
				var select = profile_list.get_selection()
				if select == -1:
					set_mode(MODES.CREATE)
				else:
					register_to_profile(select)
		MODES.CREATE:
			print("boop " + input)
			if(input == "up" && event == "down"):
				create_interface.next_character()
			elif(input == "down" && event == "down"):
				create_interface.last_character()
func register_to_gamepad():
	set_mode(MODES.SELECT)

func load_profile(name):
	pass

func register_to_profile(profile_name):
	pass

func set_mode(new_mode):
	mode = new_mode
	
	profile_list.visible = false
	create_interface.visible = false
	start_message.visible = false
	
	match mode:
		MODES.UNUSED:
			start_message.visible = true
		MODES.SELECT:
			profile_list.visible = true
			profile_list.update_labels()
		MODES.CREATE:
			create_interface.visible = true
