extends Node2D

@onready var animation:= $AnimationPlayer
var play_counter = 0
@export var fade_speed_seconds = 3
@export var loop_amount = 2
var done = false
@export var enable: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play("splash_screen")
	animation.speed_scale = 2
	visible = enable

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !animation.is_playing():
		animation.play()
		play_counter += 1
		
	if modulate.a <= 0:
		queue_free()
	elif play_counter >= loop_amount:
		modulate.a -= delta / fade_speed_seconds
