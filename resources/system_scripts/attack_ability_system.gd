extends AbilitySystem
class_name AttackAbilitySystem

@export var projectile_scene : PackedScene

var abilities_arr : ComponentArray = EcsCoordinator.get_component_array(AttackAbility)
var inputs_arr : ComponentArray = EcsCoordinator.get_component_array(InputAction)
var cbds : ComponentArray = EcsCoordinator.get_component_array(ECSCharacterBody2D)

func update(delta : float) -> void:
	for entity in entities.keys():
		var attack : AttackAbility = abilities_arr.components[abilities_arr.entity_to_index[entity]]
		var inputs : InputAction = inputs_arr.components[inputs_arr.entity_to_index[entity]]
		var cbd : ECSCharacterBody2D = cbds.components[cbds.entity_to_index[entity]]
		if attack.ready and inputs.is_action_just_pressed("attack"):
			_spawn_projectile(cbd, inputs)
			_trigger_ability(attack, true)
		_update_cooldwons(attack, delta)

func _spawn_projectile(cbd : ECSCharacterBody2D, input : InputAction) -> void:
	var projectile = projectile_scene.instantiate()
	var pos : Vector2 = cbd.global_position + cbd.facing_direction * 4
	var cmo : ConstantMotionComponent = projectile.get_node("ConstantMotionComponent")
	cmo.node_to_move.position = pos
	cmo.direction = cbd.facing_direction
	var fire_sprite = projectile.get_node("FireProjectile")
	fire_sprite.fire(cbd.facing_direction)
	cbd.add_child(projectile)
