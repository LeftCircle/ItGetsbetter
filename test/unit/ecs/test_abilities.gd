extends GutTest

var ability_system = AbilitySystem.new()

func before_each() -> void:
	ability_system = AbilitySystem.new()

func test_triggering_ability_deactivates_ability() -> void:
	var abilities : Abilities = Abilities.new()
	abilities.run.cooldown = 1.0
	assert_true(abilities.run.ready)
	ability_system.trigger_ability(abilities.run)
	assert_false(abilities.run.ready)

func test_triggering_ability_creates_cooldown_timer() -> void:
	var abilities : Abilities = Abilities.new()
	abilities.run.cooldown = 1.0
	assert_true(abilities.run.ready)
	ability_system.trigger_ability(abilities.run)
	assert_true(ability_system.cooldown_times.has(abilities.run.cooldown))
	assert_true(ability_system.abilities_in_cooldown.has(abilities.run))

func test_update_decreases_cooldown_timer() -> void:
	var abilities : Abilities = Abilities.new()
	abilities.run.cooldown = 1.0
	ability_system.trigger_ability(abilities.run)
	ability_system.update(0.5)
	assert_almost_eq(0.5, ability_system.cooldown_times[0], 0.0001)

func test_update_removes_ability_from_cooldown_when_timer_reaches_zero() -> void:
	var abilities : Abilities = Abilities.new()
	abilities.run.cooldown = 1.0
	abilities.jump.cooldown = 2.0
	ability_system.trigger_ability(abilities.run)
	ability_system.trigger_ability(abilities.jump)
	ability_system.update(1.0)
	assert_false(ability_system.abilities_in_cooldown.has(abilities.run))
	assert_true(ability_system.abilities_in_cooldown.has(abilities.jump))
	assert_almost_eq(1.0, ability_system.cooldown_times[0], 0.0001)
	assert_true(abilities.run.ready)

func test_countdown_for_jump_does_not_start_until_back_on_ground() -> void:
	assert_true(false, "NYI")
