extends Node2D

# project requirements
# main menu
# currency system?
# one level
# - level can send back info to parent game class like that the round ended and such using signals maybe
# - has start round function
# multiple difficulties
# - difficulty class
# - easy to initialise
# sandwhich crafting
# - crafted item/sandwich class, type is item
# -- craft function
# -- function to compare with customers order
# - ingredients, type is item
# -- move ingredient functions to a more generalized item class
# customers
# - decide what they will order based on difficulty
# - arrive
# - order food
# - get impatient
# - eat
# - pay
# - leave
# chairs and a class to check for free seats

var customers = preload("res://objects/customer.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var chairs
	var entrances
	for child in self.get_children():
		if child.is_class("Chair"):
			chairs.append(child)
		elif child.is_class("Entrance"):
			entrances.append(child)
			


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

