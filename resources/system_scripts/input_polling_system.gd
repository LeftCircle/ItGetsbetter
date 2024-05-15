extends System
class_name InputPollingSystem

var input_array : ComponentArray = EcsCoordinator.get_component_array(InputAction)

func update(delta : float) -> void:
	for entity in entities.keys():
		var inputs : InputAction = input_array.get_data(entity)
		inputs.previous_action.duplicate(inputs.current_action)
		inputs.current_action.input_vector = Input.get_vector("move_left", "move_right", "move_down", "move_up")
		inputs.current_action.jump = Input.is_action_pressed("jump")
		inputs.current_action.attack = Input.is_action_pressed("attack")
		inputs.current_action.mirror_inputs = Input.is_action_just_pressed("mirror_inputs")

