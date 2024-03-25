extends Node

class_name Game

#var level = preload("")

enum INPUT_SCHEMES { KEYBOARD_AND_MOUSE, CONTROLLER }
@export var INPUT_SCHEME: INPUT_SCHEMES = INPUT_SCHEMES.KEYBOARD_AND_MOUSE

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
