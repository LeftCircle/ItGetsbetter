extends System
class_name AbilitySystem

var cooldown_times : Array[float] = []
var abilities_in_cooldown : Array[Ability] = []
var jump_wait_for_cooldown : Array[Ability] = []
var cbd_waiting_for_jump_cooldown : Array[ECSCharacterBody2D] = []

var abilities_arr : ComponentArray = EcsCoordinator.get_component_array(Abilities)
var inputs_arr : ComponentArray = EcsCoordinator.get_component_array(InputAction)
var cbds : ComponentArray = EcsCoordinator.get_component_array(ECSCharacterBody2D)

func update(delta : float) -> void:
	_update_wait_for_cooldown()
	_update_cooldowns(delta)
	_update_abilities()

func _update_wait_for_cooldown() -> void:
	for i in range(cbd_waiting_for_jump_cooldown.size() - 1, -1, -1):
		if cbd_waiting_for_jump_cooldown[i].is_on_floor():
			_add_to_cooldowns(jump_wait_for_cooldown[i])
			jump_wait_for_cooldown.remove_at(i)
			cbd_waiting_for_jump_cooldown.remove_at(i)

func _update_cooldowns(delta : float) -> void:
	for i in range(cooldown_times.size() - 1, -1, -1):
		cooldown_times[i] -= delta
		abilities_in_cooldown[i].percent = int(cooldown_times[i] / abilities_in_cooldown[i].cooldown * 100)
		if cooldown_times[i] <= 0:
			cooldown_times.remove_at(i)
			abilities_in_cooldown[i].ready = true
			abilities_in_cooldown[i].percent = 0
			abilities_in_cooldown.remove_at(i)

func _update_abilities() -> void:
	for entity in entities.keys():
		var abilities : Abilities = abilities_arr.components[abilities_arr.entity_to_index[entity]]
		var inputs : InputAction = inputs_arr.components[inputs_arr.entity_to_index[entity]]
		var cbd : ECSCharacterBody2D = cbds.components[cbds.entity_to_index[entity]]
		if abilities.jump.ready and inputs.is_action_pressed("jump") and cbd.is_on_floor():
			trigger_jump(abilities.jump, cbd)
		if abilities.run.ready and inputs.is_direction_pressed():
			trigger_ability(abilities.run)
		if abilities.attack.ready and inputs.is_action_pressed("attack"):
			trigger_ability(abilities.attack)
		if abilities.wall_jump.ready and inputs.is_action_pressed("jump") and cbd.is_on_wall_only():
			trigger_jump(abilities.wall_jump, cbd)

func trigger_ability(ability : Ability) -> void:
	ability.ready = false
	_add_to_cooldowns(ability)

func _add_to_cooldowns(ability : Ability) -> void:
	if ability.cooldown > 0:
		ability.percent = 100
		cooldown_times.append(ability.cooldown)
		abilities_in_cooldown.append(ability)
	else:
		ability.ready = true

func trigger_jump(ability : Ability, cbd : ECSCharacterBody2D) -> void:
	cbd.velocity.y = -cbd.jump_speed
	ability.ready = false
	jump_wait_for_cooldown.append(ability)
	cbd_waiting_for_jump_cooldown.append(cbd)
	ability.percent = 100
