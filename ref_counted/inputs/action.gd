extends RefCounted
class_name SingleFrameAction

var input_vector : Vector2 = Vector2.ZERO
var run : bool = false
var jump : bool = false
var attack : bool = false
var mirror_inputs : bool = false

func duplicate(other_action : SingleFrameAction) -> void:
	input_vector = other_action.input_vector
	run = other_action.run
	jump = other_action.jump
	attack = other_action.attack
	mirror_inputs = other_action.mirror_inputs
