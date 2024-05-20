extends GutTest

var main_character_path : String = "res://scenes/characters/player_character/player_character.tscn"
var other_character_path : String = "res://scenes/characters/player_character/follower_char.tscn"

func test_get_character_to_follow_another() -> void:
	var main_char = add_child_autoqfree(load(main_character_path).instantiate())
	var other_character = add_child_autoqfree(load(other_character_path).instantiate())
	CharacterFollowSetter.get_a_to_follow_b(other_character.entity_id, main_char.entity_id, 15)
	assert_eq(EcsCoordinator.get_component(other_character.entity_id, FollowComponent).frames_to_wait, 15)
	assert_eq(EcsCoordinator.get_component(other_character.entity_id, FollowComponent).input_history.size(), 15)

func test_read_and_write_inputs() -> void:
	# Test that read inputs start at zero, then write inputs start x frames later
	# Test that reading causes the read index to advance by 1, and the write index to also advance by 1
	var follow_comp : FollowComponent = FollowComponent.new()
	follow_comp.frames_to_wait = 15
	assert_eq(follow_comp.get_write_index(), 14)
