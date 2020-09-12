extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

static func register_actions(actions):
	for action in actions:
		if not InputMap.has_action(action):
			InputMap.add_action(action)
			
		InputMap.action_add_event(action, deserialize_event(actions[action]))

static func deserialize_event(event):
	match event.type:
		JoypadMotion:
		JoypadButton:
		MIDI:
		
	
	pass
	
static func serialize_event(event):
	
	pass
