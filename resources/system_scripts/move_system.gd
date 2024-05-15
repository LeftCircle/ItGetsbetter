extends System
class_name MoveSystem

var character_body_array : ComponentArray = EcsCoordinator.get_component_array(ECSCharacterBody2D)
var inputs : ComponentArray = EcsCoordinator.get_component_array(InputAction)

func update(delta : float) -> void:
	for entity in entities.keys():
		var cbd : ECSCharacterBody2D = character_body_array.components[character_body_array.entity_to_index[entity]]
		var input : InputAction = inputs.components[inputs.entity_to_index[entity]]
		move_left_right(cbd, input, delta)

func move_left_right(cbd : ECSCharacterBody2D, input : InputAction, delta : float) -> void:
	var acceleration = cbd.acceleration
	if sign(cbd.velocity.x) != sign(input.current_action.input_vector.x):
		acceleration *= cbd.decelleration_mod
	var input_vel : Vector2 = Vector2(cbd.max_speed * input.current_action.input_vector.x, cbd.velocity.y)
	cbd.velocity = cbd.velocity.move_toward(input_vel, acceleration * delta)
	if input.current_action.input_vector.x != 0:
		cbd.facing_direction = Vector2.LEFT if input.current_action.input_vector.x < 0 else Vector2.RIGHT
