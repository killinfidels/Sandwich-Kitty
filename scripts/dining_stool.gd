extends Node2D

class_name Chair

var available = true
var sitting_customer: Customer = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func sit(customer):
	sitting_customer = customer
	return $"Sit Position".global_position
