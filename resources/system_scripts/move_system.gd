extends AbilitySystem
class_name MoveSystem

var character_body_array : ComponentArray = EcsCoordinator.get_component_array(ECSCharacterBody2D)
var inputs : ComponentArray = EcsCoordinator.get_component_array(InputAction)
var abilities_arr : ComponentArray = EcsCoordinator.get_component_array(RunAbilityComponent)
var empty_input = InputAction.new()

func update(delta : float) -> void:
	for entity in entities.keys():
		var run : RunAbilityComponent = abilities_arr.components[abilities_arr.entity_to_index[entity]]
		var input : InputAction = inputs.components[inputs.entity_to_index[entity]]
		var cbd : ECSCharacterBody2D = character_body_array.components[character_body_array.entity_to_index[entity]]
		if run.ready and input.is_direction_pressed():
			_trigger_ability(run, true)
			move_left_right(cbd, input, delta)
		else:
			move_left_right(cbd, empty_input, delta)
		_update_cooldwons(run, delta)

func move_left_right(cbd : ECSCharacterBody2D, input : InputAction, delta : float) -> void:
	var acceleration = cbd.acceleration
	if sign(cbd.velocity.x) != sign(input.current_action.input_vector.x):
		acceleration *= cbd.decelleration_mod
	var input_vel : Vector2 = Vector2(cbd.max_speed * input.current_action.input_vector.x, cbd.velocity.y)
	cbd.velocity = cbd.velocity.move_toward(input_vel, acceleration * delta)
	if input.current_action.input_vector.x != 0:
		cbd.facing_direction = Vector2.LEFT if input.current_action.input_vector.x < 0 else Vector2.RIGHT
