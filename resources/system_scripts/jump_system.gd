extends AbilitySystem
class_name JumpSystem

var inputs_arr : ComponentArray = EcsCoordinator.get_component_array(InputAction)
var cbds : ComponentArray = EcsCoordinator.get_component_array(ECSCharacterBody2D)
var jump_arr : ComponentArray = EcsCoordinator.get_component_array(JumpComponent)


func update(delta : float) -> void:
	for entity in entities.keys():
		var inputs : InputAction = inputs_arr.components[inputs_arr.entity_to_index[entity]]
		var cbd : ECSCharacterBody2D = cbds.components[cbds.entity_to_index[entity]]
		var jump : JumpComponent = jump_arr.components[jump_arr.entity_to_index[entity]]
		if not inputs.jump_released:
			inputs.jump_released = inputs.is_action_just_released("jump")
		if jump.ready and inputs.is_action_pressed("jump") and cbd.is_on_floor() and inputs.jump_released:
			cbd.velocity.y = -cbd.jump_speed
			_trigger_ability(jump, false)
			inputs.jump_released = false
		if cbd.is_on_floor():
			jump.countdown_can_start = true
		if not inputs.is_action_pressed("jump") and not cbd.velocity.y > 0 and jump.is_active:
			cbd.velocity.y = 0
		_update_cooldwons(jump, delta)
