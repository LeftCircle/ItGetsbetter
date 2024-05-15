extends Component
class_name FollowComponent

const STEPS_BEFORE_FOLLOW = 5

@export_range(0, 300, 1) var frames_to_wait : int = 1 : set = set_frames_to_wait

var entity_to_follow : int
var input_history : Array[SingleFrameAction] = []
var read_index : int = 0
var write_index : int = 0
var n_follow_steps : int = 0
var has_moved : bool = false
var input_to_copy : SingleFrameAction = SingleFrameAction.new()
var has_input_to_copy : bool = false

func _init_class_id() -> void:
	class_id = "FOL"

func set_frames_to_wait(value : int) -> void:
	frames_to_wait = value
	for i in range(frames_to_wait):
		input_history.append(SingleFrameAction.new())
	write_index = frames_to_wait - 1

func read_input() -> SingleFrameAction:
	var action = input_history[read_index]
	read_index = (read_index + 1) % frames_to_wait
	return action

func write_input(action : SingleFrameAction) -> void:
	input_history[write_index].duplicate(action)
	write_index = (write_index + 1) % frames_to_wait
