extends Item

class_name Sandwich

# sandwhich crafting
# - crafted item/sandwich class, type is item
# -- craft function
# -- function to compare with customers order
# - ingredients, type is item
# -- move ingredient functions to a more generalized item class

enum INGREDIENTS {CHEESE, MEAT, EGG, CUCUMBER, MUSTARD, KETCHUP}
var ingredient_strings  = ["CHEESE", "MEAT", "EGG", "CUCUMBER", "MUSTARD", "KETCHUP"]
@onready var ingredient_sprites = [$Cheese, $Meat, $Egg, $Cucumber, $Mustard, $Ketchup]
var sandwich_ingredients = []

func _ready():
	super._ready()
	item_name = "sandwich"
	print("	" + item_name)
	for item in ingredient_sprites:
		item.visible = false

func _process(delta):
	super._process(delta)

func make(ingredients):
	#ingredients is an array with the index of the ingredients to add
	for item in ingredients:
		# checks if ingredient already added
		if sandwich_ingredients.find(item) != -1:
			print(ingredient_strings[item] + " already added")
			continue
		# adds ingredient and turns on its sprite
		sandwich_ingredients.append(item)
		ingredient_sprites[item].visible = true
		print(ingredient_strings[item] + " added")
	print("sandwich crafted!")
	print()
