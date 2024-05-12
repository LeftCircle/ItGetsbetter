extends System
class_name InputPollingSystem

var input_array : ComponentArray = EcsCoordinator.get_component_array(InputAction)

func update(delta : float) -> void:
	for entity in entities.keys():
		var inputs : InputAction = input_array.get_data(entity)
		inputs.input_vector = Input.get_vector("move_left", "move_right", "move_down", "move_up")