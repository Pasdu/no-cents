extends Node

export var game_title = "Arcade Game"

onready var player_panels

onready var profile_manager = preload("res://arcade/player profile/profile_manager.gd").new(game_title)

onready var toolbar = preload("res://arcade/interface/menu bar.tscn").instance()


func _ready():
	
	call_deferred('set_up_ui')
	
func assign_controller_to_panel(player):
	disconnect("p" + String(player) + "_input_down" , self, "_unregistered_player_input")
	
	var panel = get_next_panel()
	panel.register_to_gamepad()	
	connect("p" + String(player) + "_input_down", panel, "_handle_input", ["down"])
	connect("p" + String(player) + "_input_up", panel, "_handle_input", ["up"])	

func _unregistered_player_input(input, player):
	if input == "start":
		assign_controller_to_panel(player)

func get_next_panel():
	return player_panels.pop_front()
	
func set_up_ui():
	add_child(toolbar)
	toolbar.connect("load_game", self, "load_game")

func load_game(path):
	print(path)
	print(ProjectSettings.load_resource_pack(path))
	yield(get_tree(), "idle_frame")
	var game = load("res://game.tscn").instance()
	yield(get_tree(), "idle_frame")
	get_tree().get_root().add_child(game)
