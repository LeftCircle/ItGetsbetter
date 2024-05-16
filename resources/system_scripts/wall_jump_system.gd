extends AbilitySystem
class_name WallJumpSystem

const angle_off_wall_deg : int = -45

var inputs_arr : ComponentArray = EcsCoordinator.get_component_array(InputAction)
var cbds : ComponentArray = EcsCoordinator.get_component_array(ECSCharacterBody2D)
var jump_arr : ComponentArray = EcsCoordinator.get_component_array(WallJumpComponent)

func trigger_walljump(wall_jump : WallJumpComponent, cbd : ECSCharacterBody2D) -> void:
	var wall_norm : Vector2 = cbd.last_wall_normal
	var deg = angle_off_wall_deg * wall_norm.x
	wall_jump.bounce_dir = wall_norm.rotated(deg_to_rad(deg))
	cbd.velocity = wall_jump.bounce_dir * wall_jump.impulse
	wall_jump.frames_since_jump = 0

func update(delta : float) -> void:
	for entity in entities.keys():
		var inputs : InputAction = inputs_arr.components[inputs_arr.entity_to_index[entity]]
		var cbd : ECSCharacterBody2D = cbds.components[cbds.entity_to_index[entity]]
		var wall_jump : WallJumpComponent = jump_arr.components[jump_arr.entity_to_index[entity]]
		if not inputs.jump_released:
			inputs.jump_released = inputs.is_action_just_released("jump")
		if not wall_jump.is_active and wall_jump.ready and inputs.is_action_pressed("jump") and cbd.wall_recently_hit and inputs.jump_released:
			trigger_walljump(wall_jump, cbd)
			_trigger_ability(wall_jump, true)
			inputs.jump_released = false
		if wall_jump.is_active:
			if wall_jump.frames_since_jump > wall_jump.dash_frames:
				if not inputs.is_action_pressed("jump") and not cbd.velocity.y > 0:
					cbd.velocity.y = 0
			else:
				cbd.velocity = wall_jump.bounce_dir * wall_jump.impulse
			wall_jump.frames_since_jump += 1
		_update_cooldwons(wall_jump, delta)

