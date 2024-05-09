extends StaticBody2D

class_name SandwichMaker

var held_ingredients := PackedInt32Array([])

var ingredient_objects = []

var crafted_sandwich : Sandwich

var sandwichFile = preload("res://scenes/objects/sandwich.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if crafted_sandwich:
		if crafted_sandwich.held_by != self:
			crafted_sandwich = null
	$ProgressBar.value = 5 - $"crafting timer".time_left

func placeIngredient(item):
	if item is Ingredient:
		if crafted_sandwich:
			print("cant add ingredient: sandwich inside")
		elif held_ingredients.find(item.INGREDIENT) != -1:
			print(held_ingredients.find(item.INGREDIENT))
			print("cant add ingredient: duplicate inside")
			print(held_ingredients)
		else:
			add_ingredient(item)
			return true
	
	return false

func takeSandwich():
	if crafted_sandwich:
		return crafted_sandwich
	return false

func add_ingredient(ingredient : Ingredient):
	ingredient.use(self)
	ingredient_objects.append(ingredient)
	held_ingredients.append(ingredient.INGREDIENT)
	if $"crafting timer".is_stopped():
		$"crafting timer".start()


func _on_crafting_timer_timeout():
	crafted_sandwich = sandwichFile.instantiate()
	crafted_sandwich.make(held_ingredients)
	crafted_sandwich.use(self)
	get_parent().add_child(crafted_sandwich)
	held_ingredients.clear()
	ingredient_objects.clear()
