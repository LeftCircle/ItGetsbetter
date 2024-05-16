extends AbilitySystem
class_name MirrorInputAbilitySystem

var abilities_arr : ComponentArray = EcsCoordinator.get_component_array(MirrorInputComponent)
var inputs_arr : ComponentArray = EcsCoordinator.get_component_array(InputAction)

func update(_delta : float) -> void:
	for entity in entities.keys():
		var mirror_inputs : MirrorInputComponent = abilities_arr.components[abilities_arr.entity_to_index[entity]]
		var inputs : InputAction = inputs_arr.components[inputs_arr.entity_to_index[entity]]
		if mirror_inputs.ready and inputs.is_action_just_pressed("mirror_inputs"):
			mirror_inputs.mirrored = not mirror_inputs.mirrored
			_trigger_ability(mirror_inputs, true)
		_update_cooldwons(mirror_inputs, _delta)
