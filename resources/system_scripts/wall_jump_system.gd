extends System
class_name WallJumpSystem

const angle_off_wall_deg : int = -45

var inputs_arr : ComponentArray = EcsCoordinator.get_component_array(InputAction)
var cbds : ComponentArray = EcsCoordinator.get_component_array(ECSCharacterBody2D)
var jump_arr : ComponentArray = EcsCoordinator.get_component_array(WallJumpComponent)
var entities_to_remove : Array[int] = []

static func trigger_walljump(wall_jump : WallJumpComponent, cbd : ECSCharacterBody2D) -> void:
	var wall_norm : Vector2 = cbd.last_wall_normal
	print("wall norm: ", wall_norm)
	var deg = angle_off_wall_deg * wall_norm.x
	wall_jump.bounce_dir = wall_norm.rotated(deg_to_rad(deg))
	cbd.velocity = wall_jump.bounce_dir * wall_jump.impulse
	wall_jump.frames_since_jump = 0

func register_entity(entity : int) -> void:
	## Remove the ability to move the character for a few frames.
	#EcsCoordinator.remove_component(entity, InputMoveComponent)
	super.register_entity(entity)

func update(delta : float) -> void:
	for entity in entities.keys():
		var inputs : InputAction = inputs_arr.components[inputs_arr.entity_to_index[entity]]
		var cbd : ECSCharacterBody2D = cbds.components[cbds.entity_to_index[entity]]
		var jump : WallJumpComponent = jump_arr.components[jump_arr.entity_to_index[entity]]
		if jump.frames_since_jump > jump.dash_frames:
			if not inputs.is_action_pressed("jump") and not cbd.velocity.y > 0:
				cbd.velocity.y = 0
		else:
			cbd.velocity = jump.bounce_dir * jump.impulse
		if jump.current_cooldown <= 0:
			entities_to_remove.append(entity)
			jump.ready = true
		jump.frames_since_jump += 1
	for entity in entities_to_remove:
		EcsCoordinator.remove_component(entity, WallJumpComponent)
	entities_to_remove.clear()
