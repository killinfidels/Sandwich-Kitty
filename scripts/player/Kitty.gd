extends CharacterBody2D

class_name Kitty

@export var accel : float = 1000.0
@export var damp : float = 1500.0
@export var max_speed : float = 100.0
@export var push_force : float = 60.0
@export var throw_force : float = 200.0
@export var look_direction : Vector2 = Vector2(0, 1)
@export var carry_limit : int = 1
var heldItems : Array
var rayOrAreaDetection = true

@onready var item_detector: RayCast2D = $ItemDetector
@onready var pickup_zone: Area2D = $PickupZone
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

enum INPUT_SCHEMES { KEYBOARD_AND_MOUSE, CONTROLLER }
@export var INPUT_SCHEME: INPUT_SCHEMES = INPUT_SCHEMES.KEYBOARD_AND_MOUSE

func _ready():
	animation_tree.set("parameters/Idle/blend_position", look_direction)
	updateItemDetectors()

func _process(_delta):
	if Input.is_action_just_pressed("interact"):
		interact() # places
	if Input.is_action_just_pressed("cancel"):
		cancel() # places / throws

func _physics_process(delta):
	movement(delta)
	
	pushIngredients()
	
	animate()

func movement(delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	
	if input_direction:
		match INPUT_SCHEME:
			INPUT_SCHEMES.KEYBOARD_AND_MOUSE:
				velocity += input_direction.normalized() * (accel * delta)
			INPUT_SCHEMES.CONTROLLER:
				velocity += input_direction * (accel * delta)
			_:
				print("Controller scheme?? Girl?? anyways ur value is: ", INPUT_SCHEME)
		
		# print(input_direction)
		look_direction = input_direction.normalized()
		updateItemDetectors()
	
	# slow down
	if !input_direction.x > 0.1 and !input_direction.x < -0.1:
		velocity.x = move_toward(velocity.x, 0, damp * delta)
	if !input_direction.y > 0.1 and !input_direction.y < -0.1:
		velocity.y = move_toward(velocity.y, 0, damp * delta)
	
	#set max speed
	velocity = velocity.clamp(Vector2(-max_speed * input_direction.abs().x, -max_speed * input_direction.abs().y),
	Vector2(max_speed * input_direction.abs().x, max_speed * input_direction.abs().y))
	
	move_and_slide()

func animate():
	animation_tree.set("parameters/Idle/blend_position", look_direction)
	animation_tree.set("parameters/Walk/blend_position", look_direction)
	
	if velocity != Vector2.ZERO:
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")

func pushIngredients():
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)

func pickUpZoneSort(a, b):
	if a.position.distance_to(pickup_zone.position) < b.position.distance_to(pickup_zone.position):
		return true
	return false
	
func interact():
	var item
	if !rayOrAreaDetection:
		item = item_detector.get_collider()
	else:
		var bodies = pickup_zone.get_overlapping_bodies()
		if bodies:
			bodies.sort_custom(pickUpZoneSort)
			for thing in bodies:
				print(thing.position.distance_to(pickup_zone.position))
			print()
			item = bodies[0]
		
	if !item is Ingredient: # places item if there isnt one to pick up
		return
	elif heldItems.size() >= carry_limit: # if an item is infront, check inv capacity
		print("Carry limit reached!")
	else: # pickup item if there is space
		pickUp(item)

func cancel():
	if heldItems.size():
		if velocity.length() > 10:
			throw()
		else:
			place()

func pickUp(item):
	print("Lets pretend this was picked up for now")
	heldItems.append(item)
	item.pickedUp(self, heldItems.size() - 1)

func place():
	if item_detector.get_collider() is StaticBody2D:
		print("You cant place this here dummy")
	else:
		heldItems[0].placed(item_detector.global_position, look_direction)
		removeItem(0)
		print("Lets pretend you placed something just now")

func throw():
	heldItems[0].thrown(look_direction, throw_force)
	removeItem(0)

func removeItem(index):
	heldItems.remove_at(index)
	for i in heldItems.size():
		heldItems[i].stack_index = i

func updateItemDetectors():
	item_detector.target_position = look_direction * 30
	pickup_zone.position = item_detector.position + item_detector.target_position / 2
