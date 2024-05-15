extends System
class_name AbilitySystem

var abilities_arr : ComponentArray = EcsCoordinator.get_component_array(Abilities)
var inputs_arr : ComponentArray = EcsCoordinator.get_component_array(InputAction)
var cbds : ComponentArray = EcsCoordinator.get_component_array(ECSCharacterBody2D)


func update(_delta : float) -> void:
	for entity in entities.keys():
		var abilities : Abilities = abilities_arr.components[abilities_arr.entity_to_index[entity]]
		var inputs : InputAction = inputs_arr.components[inputs_arr.entity_to_index[entity]]
		var cbd : ECSCharacterBody2D = cbds.components[cbds.entity_to_index[entity]]
		if abilities.jump.ready and inputs.is_action_pressed("jump") and cbd.is_on_floor():
			JumpSystem.trigger_jump(abilities.jump, cbd)
			EcsCoordinator.add_component(entity, abilities.jump)
		if abilities.run.ready and inputs.is_direction_pressed():
			pass
		if abilities.attack.ready and inputs.is_action_pressed("attack"):
			pass
		if abilities.wall_jump.ready and inputs.is_action_pressed("jump") and cbd.is_on_wall_only():
			WallJumpSystem.trigger_walljump(abilities.wall_jump, cbd)
			EcsCoordinator.add_component(entity, abilities.wall_jump)
			print("Triggering wall jump!!")
