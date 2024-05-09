extends Item

class_name Ingredient

enum INGREDIENTS {CHEESE, MEAT, EGG, CUCUMBER, KETCHUP, MUSTARD, BREADSLICE, BREADLOAF}
var ingredient_strings := PackedStringArray(["CHEESE", "MEAT", "EGG", "CUCUMBER", "KETCHUP", "MUSTARD", "BREADSLICE", "BREADLOAF"])
@export var INGREDIENT: INGREDIENTS
@onready var sprite: Sprite2D = $Spritesheet

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	item_name = ingredient_strings[INGREDIENT]
	print("	ingredient (" + item_name + ")")
	sprite.frame = INGREDIENT
	pickable = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	if Input.is_action_just_pressed("debug"):
		print(ingredient_strings[INGREDIENT])
		print("is_held: ", is_held)
		print()
