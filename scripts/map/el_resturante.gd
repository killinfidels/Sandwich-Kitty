extends Node2D

var customers = preload("res://scenes/objects/customer.tscn")

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
