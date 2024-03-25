extends Item

class_name Ingredient

enum INGREDIENTS {CHEESE, MEAT, EGG, CUCUMBER, KETCHUP, MUSTARD, BREADSLICE, BREADLOAF}
var ingredient_strings = ["CHEESE", "MEAT", "EGG", "CUCUMBER", "KETCHUP", "MUSTARD", "BREADSLICE", "BREADLOAF"]
@export var INGREDIENT: INGREDIENTS
@onready var sprite: Sprite2D = $Spritesheet

# Called when the node enters the scene tree for the first time.
func _ready():
	print("ingredient")
	sprite.frame = INGREDIENT
	pickable = true
	super._ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	super._process(_delta)
	if Input.is_action_just_pressed("debug"):
		print(ingredient_strings[INGREDIENT])
		print("is_held: ", is_held)
		print()
