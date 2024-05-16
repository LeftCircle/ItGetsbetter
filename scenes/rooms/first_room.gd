extends TileMap


func _ready() -> void:
	CharacterFollowSetter.get_a_to_follow_b($LeaverChar.entity_id, $PlayerCharacter.entity_id, 1)
	var ui : ECSUi = get_tree().get_first_node_in_group("HUD")
	ui.set_run(EcsCoordinator.get_component($PlayerCharacter.entity_id, RunAbilityComponent))
	ui.set_jump(EcsCoordinator.get_component($PlayerCharacter.entity_id, JumpComponent))
	ui.set_wall_jump(EcsCoordinator.get_component($PlayerCharacter.entity_id, WallJumpComponent))
	ui.set_mirror(EcsCoordinator.get_component($LeaverChar.entity_id, MirrorInputComponent))
	ui.set_attack(EcsCoordinator.get_component($LeaverChar.entity_id, AttackAbility))



