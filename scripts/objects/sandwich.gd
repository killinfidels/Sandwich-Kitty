extends Item

class_name Sandwich

# sandwhich crafting
# - crafted item/sandwich class, type is item
# -- craft function
# -- function to compare with customers order
# - ingredients, type is item
# -- move ingredient functions to a more generalized item class

enum INGREDIENTS {CHEESE, EGG, MEAT, CUCUMBER, MUSTARD, KETCHUP}
var ingredient_strings  := PackedStringArray(["CHEESE", "EGG", "MEAT", "CUCUMBER", "MUSTARD", "KETCHUP"])
@onready var ingredient_sprites = [$Cheese, $Egg, $Meat, $Cucumber, $Mustard, $Ketchup]
var sandwich_ingredients := PackedInt32Array([])

func _ready():
	super._ready()
	item_name = "sandwich"
	print("	" + item_name)
	for item in ingredient_sprites:
		item.visible = false

func _process(delta):
	super._process(delta)

func make(ingredients : PackedInt32Array):
	for ingredient in ingredients:
		# checks if ingredient already added
		if sandwich_ingredients.find(ingredient):
			print(ingredient_strings[ingredient] + " already added")
			continue
		# adds ingredient and turns on its sprite
		sandwich_ingredients.append(ingredient)
		ingredient_sprites[ingredient].visible = true
		print(ingredient_strings[ingredient] + " added")
