extends PanelContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.

func _input(event):
	if(event.is_action_pressed("menu")):
		visible =  not visible


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
