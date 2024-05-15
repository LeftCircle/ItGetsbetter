extends Component
class_name FollowComponent

const STEPS_BEFORE_FOLLOW = 5
const STOP_FRAMES_BEFORE_RESET = 3

@export_range(0, 300, 1) var frames_to_wait : int = 1 : set = set_frames_to_wait

var entity_to_follow : int
var input_history : Array[SingleFrameAction] = []
var has_moved : bool = false
var n_stop_frames : int = 0
var previous_was_zero = false

func _init_class_id() -> void:
	class_id = "FOL"

func set_frames_to_wait(value : int) -> void:
	frames_to_wait = value
	for i in range(frames_to_wait):
		input_history.append(SingleFrameAction.new())

func read_input() -> SingleFrameAction:
	return input_history.pop_front()

func write_input(action : SingleFrameAction) -> void:
	var new_action = SingleFrameAction.new()
	new_action.duplicate(action)
	input_history.append(new_action)
