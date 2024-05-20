extends ComponentNode
class_name PositionHistoryComponent

@export var node_to_track : Node2D
var position_history : Array[Vector2] = []


func _init_class_id() -> void:
	class_id = "PHI"

func _ready() -> void:
	super._ready()
	position_history.append(node_to_track.global_position)
