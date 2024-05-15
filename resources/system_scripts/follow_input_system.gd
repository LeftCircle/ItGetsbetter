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

		if not fc.has_moved and leader_inputs.current_action.input_vector.x != 0:
			fc.has_moved = true
			fc.n_stop_frames = 0
			for i in range(fc.STEPS_BEFORE_FOLLOW):
				fc.write_input(leader_inputs.current_action)
			print("Padding follow")
		fc.previous_was_zero = leader_inputs.current_action.input_vector.x == 0
		if fc.previous_was_zero and fc.has_moved:
			fc.n_stop_frames += 1
			if fc.n_stop_frames >= fc.STOP_FRAMES_BEFORE_RESET:
				fc.has_moved = false
				fc.n_stop_frames = 0
				for i in range(fc.STEPS_BEFORE_FOLLOW):
					fc.read_input()
		print(fc.input_history.size())


		follower_inputs.receive_action(old_actions)
		fc.write_input(leader_inputs.current_action)




