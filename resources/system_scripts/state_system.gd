extends System
class_name StateSystem

var states_arr : ComponentArray = EcsCoordinator.get_component_array(States)
var cbds : ComponentArray = EcsCoordinator.get_component_array(ECSCharacterBody2D)
var anim_trees : ComponentArray = EcsCoordinator.get_component_array(ECSAnimationTree)
var inputs_arr : ComponentArray = EcsCoordinator.get_component_array(InputAction)

func update(_delta):
	for entity in entities.keys():
		var cbd : ECSCharacterBody2D = cbds.components[cbds.entity_to_index[entity]]
		var states : States = states_arr.components[states_arr.entity_to_index[entity]]
		var anim_tree : ECSAnimationTree = anim_trees.components[anim_trees.entity_to_index[entity]]
		var inputs : InputAction = inputs_arr.components[inputs_arr.entity_to_index[entity]]
		if inputs.current_action.input_vector.x != 0:
			set_blend_pos(anim_tree, inputs.current_action.input_vector.x)

		if inputs.current_action.input_vector.x != 0:
			states.current_state = States.RUNNING
			play_if_not_already(anim_tree, "Run")
		elif (!cbd.is_on_floor() and !cbd.is_on_wall()):
			play_if_not_already(anim_tree, "Run")
		else:
			states.current_state = States.IDLE
			play_if_not_already(anim_tree, "Idle")

func set_blend_pos(anim_tree : ECSAnimationTree, x : float) -> void:
	anim_tree.set("parameters/Run/blend_position", x)

func play_if_not_already(anim_tree : ECSAnimationTree, anim : String) -> void:
	if anim_tree.state_machine_playback.get_current_node() != anim:
		anim_tree.state_machine_playback.travel(anim)
