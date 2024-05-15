extends System
class_name FollowInputSystem

var input_arr : ComponentArray = EcsCoordinator.get_component_array(InputAction)
var follow_arr : ComponentArray = EcsCoordinator.get_component_array(FollowComponent)

func update(_delta : float) -> void:
	for entity in entities.keys():
		var follower_inputs : InputAction = input_arr.components[input_arr.entity_to_index[entity]]
		var fc : FollowComponent = follow_arr.components[follow_arr.entity_to_index[entity]]
		var leader_inputs : InputAction = input_arr.components[input_arr.entity_to_index[fc.entity_to_follow]]
		var old_actions : SingleFrameAction = fc.read_input()
		follower_inputs.receive_action(old_actions)
		fc.write_input(leader_inputs.current_action)
