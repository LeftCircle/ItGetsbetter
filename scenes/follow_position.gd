extends Node
class_name FollowPositionComponent

@export_range(0, 300, 1) var frames_to_wait : int = 1
@export var obj_to_follow : Node
@export var obj_to_move : Node

var position_history : Array[Vector2] = []

func set_start_position(start_pos : Vector2) -> void:
	for i in range(frames_to_wait):
		position_history.append(start_pos)

func read_position() -> SingleFrameAction:
	return position_history.pop_front()

func write_position(pos : Vector2) -> void:
	position_history.append(pos)

func _physics_process(_delta : float) -> void:
	if is_instance_valid(obj_to_follow):
		var pos = obj_to_follow.global_position
		write_position(pos)
	if is_instance_valid(obj_to_move):
		obj_to_move.global_position = read_position()
