extends System
class_name AbilitySystem

@export var projectile_scene : PackedScene

var abilities_arr : ComponentArray = EcsCoordinator.get_component_array(Abilities)
var inputs_arr : ComponentArray = EcsCoordinator.get_component_array(InputAction)
var cbds : ComponentArray = EcsCoordinator.get_component_array(ECSCharacterBody2D)


func update(_delta : float) -> void:
	for entity in entities.keys():
		var abilities : Abilities = abilities_arr.components[abilities_arr.entity_to_index[entity]]
		var inputs : InputAction = inputs_arr.components[inputs_arr.entity_to_index[entity]]
		var cbd : ECSCharacterBody2D = cbds.components[cbds.entity_to_index[entity]]
		if not inputs.jump_released:
			inputs.jump_released = inputs.is_action_just_released("jump")
		if abilities.jump.ready and inputs.is_action_pressed("jump") and cbd.is_on_floor() and inputs.jump_released:
			JumpSystem.trigger_jump(abilities.jump, cbd)
			EcsCoordinator.add_component(entity, abilities.jump)
			_trigger_ability(abilities.jump, false)
			inputs.jump_released = false
		if abilities.run.ready and inputs.is_direction_pressed():
			_trigger_ability(abilities.run, true)
		if abilities.attack.ready and inputs.is_action_just_pressed("attack"):
			_spawn_projectile(cbd, inputs)
		if abilities.wall_jump.ready and inputs.is_action_pressed("jump") and cbd.wall_recently_hit and inputs.jump_released:
			WallJumpSystem.trigger_walljump(abilities.wall_jump, cbd)
			EcsCoordinator.add_component(entity, abilities.wall_jump)
			_trigger_ability(abilities.wall_jump, true)
			inputs.jump_released = false
		if abilities.mirror_inputs.ready and inputs.is_action_just_pressed("mirror_inputs"):
			abilities.mirror_inputs.mirrored = not abilities.mirror_inputs.mirrored
			_trigger_ability(abilities.mirror_inputs, true)
		_update_cooldwons(abilities.jump, _delta)
		_update_cooldwons(abilities.run, _delta)
		_update_cooldwons(abilities.attack, _delta)
		_update_cooldwons(abilities.wall_jump, _delta)
		_update_cooldwons(abilities.mirror_inputs, _delta)

func _trigger_ability(ability : Ability, can_countdown_start : bool) -> void:
	ability.ready = false
	ability.current_cooldown = ability.cooldown
	ability.countdown_can_start = can_countdown_start

func _spawn_projectile(cbd : ECSCharacterBody2D, input : InputAction) -> void:
	# Spawn the projectile at the characters position offset by the direction they are facing
	var projectile = projectile_scene.instantiate()
	var pos : Vector2 = cbd.global_position + cbd.facing_direction * 4
	var cmo : ConstantMotionComponent = projectile.get_node("ConstantMotionComponent")
	cmo.node_to_move.position = pos
	cmo.direction = cbd.facing_direction
	var fire_sprite = projectile.get_node("FireProjectile")
	fire_sprite.fire(cbd.facing_direction)
	cbd.add_child(projectile)

func _update_cooldwons(ability : Ability, delta : float) -> void:
	# If the ability is not ready but cooldown can start, start the cooldown!
	if !ability.ready and ability.countdown_can_start:
		ability.current_cooldown -= delta
		if ability.current_cooldown <= 0:
			ability.ready = true
			ability.current_cooldown = 0
			ability.countdown_can_start = false
