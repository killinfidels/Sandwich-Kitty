extends RigidBody2D # maybe item?

class_name Customer
# bounces around in the waves outside, then bounces in
# when it hits a wall again inside it will bounce to a chair spinning comically

var can_sit: bool = true
enum ASS_STATES { NORMAL, HURTING, DESTROYED, WANTS_PLEASURE, IS_PLEASURED, PRETTY}
var ASS_STATE = ASS_STATES.NORMAL
# var order : CraftedItem

# Called when the node enters the scene tree for the first time.
func _ready():
	if ASS_STATE != ASS_STATES.DESTROYED:
		can_sit = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
