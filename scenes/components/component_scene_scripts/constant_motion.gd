extends ComponentNode
class_name ConstantMotionComponent

@export var node_to_move : Node2D
@export_range(1, 500) var speed : int = 100

var direction : Vector2 = Vector2.RIGHT

func _init_class_id() -> void:
	class_id = "CMO"
