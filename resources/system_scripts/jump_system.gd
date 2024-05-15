extends System
class_name JumpSystem

var inputs_arr : ComponentArray = EcsCoordinator.get_component_array(InputAction)
var cbds : ComponentArray = EcsCoordinator.get_component_array(ECSCharacterBody2D)
var jump_arr : ComponentArray = EcsCoordinator.get_component_array(JumpComponent)
var entities_to_remove : Array[int] = []

static func trigger_jump(jump : JumpComponent, cbd : ECSCharacterBody2D) -> void:
	cbd.velocity.y = -cbd.jump_speed
	jump.ready = false
	jump.countdown_can_start = false
	jump.current_cooldown = jump.cooldown

func update(delta : float) -> void:
	for entity in entities.keys():
		var inputs : InputAction = inputs_arr.components[inputs_arr.entity_to_index[entity]]
		var cbd : ECSCharacterBody2D = cbds.components[cbds.entity_to_index[entity]]
		var jump : JumpComponent = jump_arr.components[jump_arr.entity_to_index[entity]]
		if cbd.is_on_floor():
			jump.countdown_can_start = true
		if not inputs.is_action_pressed("jump") and not cbd.velocity.y > 0:
			cbd.velocity.y = 0
		if jump.countdown_can_start:
			jump.current_cooldown -= delta
		if jump.current_cooldown <= 0:
			entities_to_remove.append(entity)
			jump.ready = true
	for entity in entities_to_remove:
		EcsCoordinator.remove_component(entity, JumpComponent)
	entities_to_remove.clear()
