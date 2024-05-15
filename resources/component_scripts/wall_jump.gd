extends Ability
class_name WallJumpComponent

@export var impulse = 250
#@export_range(0, 180, 1) var angle_off_wall_deg : int = -45
@export_range(1, 30) var dash_frames : int = 15

var frames_since_jump : int = 0
var bounce_dir : Vector2

func _init_class_id() -> void:
	class_id = "WJP"
