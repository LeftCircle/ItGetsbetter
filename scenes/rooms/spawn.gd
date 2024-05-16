extends TileMap
class_name BaseRoom

@export var next_scene : PackedScene
@export var leader : Entity
@export var follower : Entity

var has_leader : bool = false
var has_follower : bool = false


func _ready() -> void:
	CharacterFollowSetter.get_a_to_follow_b(follower.entity_id, leader.entity_id, 1)
	var ui : ECSUi = get_tree().get_first_node_in_group("HUD")
	ui.set_run(EcsCoordinator.get_component(leader.entity_id, RunAbilityComponent))
	ui.set_jump(EcsCoordinator.get_component(leader.entity_id, JumpComponent))
	ui.set_wall_jump(EcsCoordinator.get_component(leader.entity_id, WallJumpComponent))
	ui.set_mirror(EcsCoordinator.get_component(follower.entity_id, MirrorInputComponent))
	ui.set_attack(EcsCoordinator.get_component(follower.entity_id, AttackAbility))

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == leader:
		has_leader = true
	if body == follower:
		has_follower = true
	if has_leader and has_follower:
		get_tree().call_deferred("change_scene_to_packed", next_scene)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == leader:
		has_leader = false
	if body == follower:
		has_follower = false
