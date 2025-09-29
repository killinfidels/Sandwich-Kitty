extends Node2D

var resetPoint : Vector2
var resetDirection : Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resetPoint = $FishPathRay.position
	resetDirection = $FishPathRay.target_position
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

var rayArray : PackedVector2Array
var outcasts : Array
var winners : Array
var slices = 50
func _physics_process(_delta: float) -> void:
	if Input.is_action_just_released("interact"):
		for winner in winners:
			winner.queue_free()
		winners.clear()
		for i in slices:
			rayArray.clear()
			var rayLine = Line2D.new()
			if (bounceCast()):
				rayLine.default_color = Color(1, 0, 0)
				winners.append(rayLine)
			else:
				outcasts.append(rayLine)
			rayLine.points = rayArray
			rayLine.set_joint_mode(Line2D.LINE_JOINT_ROUND)
			rayLine.width = 1
			add_child(rayLine)
			$FishPathRay.position = resetPoint
			resetDirection = resetDirection.rotated(2 * PI / slices)
			$FishPathRay.target_position = resetDirection
			$FishPathRay.force_raycast_update()
		for loser in outcasts:
			loser.queue_free()
		outcasts.clear()

		print("Slices: ", slices)
		print("Losers: ", outcasts.size())
		print("Winners: ", winners.size())
		print()
		slices += 50
	
	if Input.is_action_just_pressed("cancel"):
		for loser in outcasts:
			loser.queue_free()
		outcasts.clear()
		print(winners.pick_random().points)
	
func bounceCast():
	var flag = false
	for i in 10:
		if !$FishPathRay.is_colliding():
			return flag
		else:
			if i == 0:
				rayArray.append($FishPathRay.position)
			var newPoint : Vector2 = $FishPathRay.get_collision_point()
			var newDirection : Vector2 = $FishPathRay.get_collision_normal()
			rayArray.append(newPoint)
			var collider = $FishPathRay.get_collider()
			$FishPathRay.position = newPoint - $FishPathRay.target_position.normalized()
			$FishPathRay.target_position = $FishPathRay.target_position.bounce(newDirection)
			$FishPathRay.force_raycast_update()
			if collider.name == "Exit":
				i = 10 - 2
				flag = true
