extends Component
class_name FollowComponent

@export_range(0, 300, 1) var frames_to_wait : int = 1 : set = set_frames_to_wait

var entity_to_follow : int
var input_history : Array[SingleFrameAction] = []
var read_index = 0

func _init_class_id() -> void:
	class_id = "FOL"

func set_frames_to_wait(value : int) -> void:
	frames_to_wait = value
	for i in range(frames_to_wait):
		input_history.append(SingleFrameAction.new())

func read_input() -> SingleFrameAction:
	var action = input_history[read_index]
	read_index = (read_index + 1) % frames_to_wait
	return action

func write_input(action : SingleFrameAction) -> void:
	var write_index : int = get_write_index()
	input_history[write_index].duplicate(action)

func get_write_index() -> int:
	return posmod(read_index - 1, frames_to_wait)
