extends TileMap
class_name BaseRoom

@export var leader : Entity
@export var follower : Entity

func _ready() -> void:
	CharacterFollowSetter.get_a_to_follow_b(follower.entity_id, leader.entity_id, 1)
	var ui : ECSUi = get_tree().get_first_node_in_group("HUD")
	ui.set_run(EcsCoordinator.get_component(leader.entity_id, RunAbilityComponent))
	ui.set_jump(EcsCoordinator.get_component(leader.entity_id, JumpComponent))
	ui.set_wall_jump(EcsCoordinator.get_component(leader.entity_id, WallJumpComponent))
	ui.set_mirror(EcsCoordinator.get_component(follower.entity_id, MirrorInputComponent))
	ui.set_attack(EcsCoordinator.get_component(follower.entity_id, AttackAbility))
