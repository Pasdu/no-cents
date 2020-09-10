extends Node

export var game_title = "Arcade Game"

signal p1_input_down(msg)
signal p2_input_down(msg)
signal p3_input_down(msg)
signal p4_input_down(msg)

signal p1_input_up(msg)
signal p2_input_up(msg)
signal p3_input_up(msg)
signal p4_input_up(msg)

onready var player_panels

onready var profile_manager = preload("res://arcade/player profile/profile_manager.gd").new(game_title)

onready var overlay = preload("res://arcade/game-overlay.tscn").instance()

func _ready():
	connect("p1_input_down", self, "_unregistered_player_input", [1])
	connect("p2_input_down", self, "_unregistered_player_input", [2])
	connect("p3_input_down", self, "_unregistered_player_input", [3])
	connect("p4_input_down", self, "_unregistered_player_input", [4])
	
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
	add_child(overlay)
	player_panels = [overlay.get_node("Player_Panel"), overlay.get_node("Player_Panel2"), overlay.get_node("Player_Panel3"), overlay.get_node("Player_Panel4")]

func _input(event):
	if(event.is_action_pressed("p1_up")):
		emit_signal("p1_input_down", "up")
	if(event.is_action_pressed("p1_down")):
		emit_signal("p1_input_down", "down")
	if(event.is_action_pressed("p1_left")):
		emit_signal("p1_input_down", "left")
	if(event.is_action_pressed("p1_right")):
		emit_signal("p1_input_down", "right")
	if(event.is_action_pressed("p1_select")):
		emit_signal("p1_input_down", "select")
	if(event.is_action_pressed("p1_start")):
		emit_signal("p1_input_down", "start")
	if(event.is_action_pressed("p1_a")):
		emit_signal("p1_input_down", "a")
	if(event.is_action_pressed("p1_b")):
		emit_signal("p1_input_down", "b")
		
	if(event.is_action_released("p1_up")):
		emit_signal("p1_input_up", "up")
	if(event.is_action_released("p1_down")):
		emit_signal("p1_input_up", "down")
	if(event.is_action_released("p1_left")):
		emit_signal("p1_input_up", "left")
	if(event.is_action_released("p1_right")):
		emit_signal("p1_input_up", "right")
	if(event.is_action_released("p1_select")):
		emit_signal("p1_input_up", "select")
	if(event.is_action_released("p1_start")):
		emit_signal("p1_input_up", "start")
	if(event.is_action_released("p1_a")):
		emit_signal("p1_input_up", "a")
	if(event.is_action_released("p1_b")):
		emit_signal("p1_input_up", "b")
