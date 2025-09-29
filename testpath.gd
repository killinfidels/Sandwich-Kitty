@tool
extends Path2D
var bararyy = PackedVector2Array([Vector2(287, -275), Vector2(323.2418, -211.5), Vector2(379.8949, -312.5),
Vector2(422, -236.9898), Vector2(343, -100.3094), Vector2(415.5101, 25)])
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	curve.clear_points()
	if curve.point_count == 0:
		for i in bararyy:
			curve.add_point(i)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$PathFollow2D.progress_ratio += delta / 4
