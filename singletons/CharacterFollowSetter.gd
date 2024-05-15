extends Node


func get_a_to_follow_b(a : int, b : int, frame_delay : int) -> void:
	var fc : FollowComponent = FollowComponent.new()
	fc.frames_to_wait = frame_delay
	fc.entity_to_follow = b
	EcsCoordinator.add_component(a, fc)
