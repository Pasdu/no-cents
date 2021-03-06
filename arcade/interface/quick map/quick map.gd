extends Node

onready var dialog = get_node("dialog")

onready var player_number = get_node("contents/row1/Player/SpinBox")
onready var dpad_number = get_node("contents/row1/DPads/SpinBox")
onready var analogs_number = get_node("contents/row2/Analogs/SpinBox")
onready var buttons_number = get_node("contents/row2/Buttons/SpinBox")
onready var triggers_number = get_node("contents/row3/Triggers/SpinBox")

var input_settings = preload("res://arcade/loader/input_settings.gd")


# Called when the node enters the scene tree for the first time.
func _ready():
	dialog.get_ok().text = "cancel"
	dialog.popup()
func start_mapping():
	pass
	
func _input(event):
	if dialog.visible:
		if event.is_action_type():
			print(event)
