extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var x = 0.0
var z = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translation.x = translation.x + x
	translation.z = translation.z + z

	
func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_W:
			z = -1.0
		elif event.scancode == KEY_A:
			x = -1.0
		elif event.scancode == KEY_S:
			z = 1.0
		elif event.scancode == KEY_D:
			x = 1.0
	if event is InputEventKey and not event.pressed:
		if event.scancode == KEY_W:
			z = 0.0
		elif event.scancode == KEY_A:
			x = 0.0
		elif event.scancode == KEY_S:
			z = 0.0
		elif event.scancode == KEY_D:
			x = 0.0

	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_DOWN and event.pressed:
			translation.y = translation.y + 5
		if event.button_index == BUTTON_WHEEL_UP and event.pressed:
			translation.y = translation.y - 5
