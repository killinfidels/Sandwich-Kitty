extends RigidBody2D

class_name Item

var throw_timer: Timer = Timer.new()

var item_name : String
var is_held = false
var held_by
var thrower
var stack_index
var pickable = true

var randomJiggle := false

# Called when the node enters the scene tree for the first time.
func _ready():
	print("item init:")
	add_child(throw_timer)
	throw_timer.set_one_shot(true)
	throw_timer.set_wait_time(0.1)
	#throw_timer.process_callback = Timer.TIMER_PROCESS_PHYSICS
	throw_timer.connect("timeout", _on_throw_collision_timer_timeout)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func _integrate_forces(state):
	if is_held:
		var targetPosition = held_by.position
		targetPosition.y += - 30 - 8 * stack_index
		if randomJiggle:
			var rng = RandomNumberGenerator.new()
			targetPosition.x += rng.randi_range(-10, 10)
			targetPosition.y += rng.randi_range(-10, 10)
		var maxDistance = Vector2(3 + stack_index, 1 + stack_index)
		var xform : Transform2D = state.get_transform()
		var amountToMove = abs((xform.origin - targetPosition) / maxDistance)
		xform.origin.x = move_toward(xform.origin.x, targetPosition.x, amountToMove.x)
		xform.origin.y = move_toward(xform.origin.y, targetPosition.y, amountToMove.y)
		#print(xform)
		state.set_transform(xform)

func pickedUp(thePickerUpper, stackNumber):
	is_held = true
	held_by = thePickerUpper
	stack_index = stackNumber
	$Collision.disabled = true
	
func placed(centerPos, lookingDirection):
	global_transform.origin = centerPos + (lookingDirection * 20)
	is_held = false
	held_by = null
	$Collision.disabled = false

func thrown(direction, force):
	var forceDirection = direction * force
	apply_impulse(forceDirection, Vector2.ZERO)
	thrower = held_by
	is_held = false
	held_by = null
	# disable player collision and item collisin for 0.1 sec
	throw_timer.start()
	add_collision_exception_with(thrower)
	$Collision.disabled = false
	
func use(used_on):
	is_held = true
	held_by = used_on
	stack_index = 0
	randomJiggle = true
	$Collision.disabled = true

func _on_throw_collision_timer_timeout():
	remove_collision_exception_with(thrower)
	thrower = null
	print("uncollided")
