extends System
class_name FollowInputSystem

var input_arr : ComponentArray = EcsCoordinator.get_component_array(InputAction)
var follow_arr : ComponentArray = EcsCoordinator.get_component_array(FollowComponent)
var abilities_arr : ComponentArray = EcsCoordinator.get_component_array(Abilities)


func update(_delta : float) -> void:
	for entity in entities.keys():
		var follower_inputs : InputAction = input_arr.components[input_arr.entity_to_index[entity]]
		var mirror : MirrorInputComponent = abilities_arr.components[abilities_arr.entity_to_index[entity]].mirror_inputs
		var fc : FollowComponent = follow_arr.components[follow_arr.entity_to_index[entity]]
		var leader_inputs : InputAction = input_arr.components[input_arr.entity_to_index[fc.entity_to_follow]]
		var old_actions : SingleFrameAction = fc.read_input()
		if mirror.mirrored:
			old_actions.input_vector.x *= -1

		if fc.n_follow_steps == 0 and abs(leader_inputs.current_action.input_vector.x) != 0:
			fc.has_moved = true
			for i in range(fc.STEPS_BEFORE_FOLLOW):
				fc.write_input(leader_inputs.current_action)

		follower_inputs.receive_action(old_actions)
		fc.write_input(leader_inputs.current_action)
		fc.n_follow_steps += 1 * int(fc.has_moved)

		if fc.n_follow_steps > fc.STEPS_BEFORE_FOLLOW and abs(leader_inputs.current_action.input_vector.x) == 0 and fc.has_moved:
			fc.n_follow_steps = 0
			fc.write_index = posmod(fc.write_index - fc.STEPS_BEFORE_FOLLOW, fc._total_frames)
			print("Adjusting fc frames")
			fc.has_moved = false
		print(fc.read_index - fc.write_index)



