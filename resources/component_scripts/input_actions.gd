extends Component
class_name InputAction

var current_action : SingleFrameAction = SingleFrameAction.new()
var previous_action : SingleFrameAction = SingleFrameAction.new()
var jump_released : bool = true

func _init_class_id() -> void:
	class_id = "INP"

func receive_action(action : SingleFrameAction) -> void:
	previous_action.duplicate(current_action)
	current_action.duplicate(action)

func is_action_just_pressed(action : String) -> bool:
	return current_action.get(action) and not previous_action.get(action)

func is_action_just_released(action : String) -> bool:
	return not current_action.get(action) and previous_action.get(action)

func is_action_pressed(action : String) -> bool:
	return current_action.get(action)

func is_direction_pressed() -> bool:
	return abs(current_action.input_vector.x) > 0
