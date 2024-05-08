extends Item

class_name Sandwich

# sandwhich crafting
# - crafted item/sandwich class, type is item
# -- craft function
# -- function to compare with customers order
# - ingredients, type is item
# -- move ingredient functions to a more generalized item class

enum INGREDIENTS {CHEESE, EGG, MEAT, CUCUMBER, MUSTARD, KETCHUP}
var ingredient_strings = ["CHEESE", "EGG", "MEAT", "CUCUMBER", "MUSTARD", "KETCHUP"]
@onready var ingredient_sprites = [$Cheese, $Egg, $Meat, $Cucumber, $Mustard, $Ketchup]
var ingredients = []

func _ready():
	for item in ingredient_sprites:
		pass#item.visible = false
		
		super._ready()

func _process(delta):
	super._process(delta)


