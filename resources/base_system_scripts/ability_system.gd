extends System
class_name AbilitySystem

func _trigger_ability(ability : Ability, can_countdown_start : bool) -> void:
	ability.ready = false
	ability.current_cooldown = ability.cooldown
	ability.countdown_can_start = can_countdown_start
	ability.is_active = true

func _update_cooldwons(ability : Ability, delta : float) -> void:
	if !ability.ready and ability.countdown_can_start:
		ability.current_cooldown -= delta
		if ability.current_cooldown <= 0:
			ability.ready = true
			ability.current_cooldown = 0
			ability.countdown_can_start = false
			ability.is_active = false
