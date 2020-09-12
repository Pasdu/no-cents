extends PanelContainer

signal load_game(path)

onready var file_picker = preload("res://arcade/interface/load_rom.tscn").instance()


func _ready():
	var popup = get_node("items/Main").get_popup()
	popup.connect("index_pressed", self, "_file_menu")
	
	file_picker.connect("file_selected", self, "_confirmed")
	add_child(file_picker)

# Called when the node enters the scene tree for the first time.

func _input(event):
	if(event.is_action_pressed("menu")):
		visible = not visible

func _file_menu(index):
	print(index)
	match index:
		0:
			file_picker.popup()


func _file_selected(path):
	self.path = path
	
func _confirmed(path):
	emit_signal("load_game", path)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
