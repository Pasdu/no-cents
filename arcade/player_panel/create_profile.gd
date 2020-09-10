extends Node

const characters = [ "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" ]
var current_character = 0

onready var entered_text = get_node("field/Name")
onready var next_character = get_node("field/NextCharacter")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func next_character():
	current_character = ( current_character + 1 ) % characters.size()
	update_character()
	
func last_character():
	current_character = ( current_character - 1 ) % characters.size()
	update_character()

func update_character():
	next_character.text = characters[current_character]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
