extends TileMap
class_name BaseRoom

@export var leader : Entity
@export var follower : Entity
@export var void_scene : PackedScene = load("res://scenes/characters/void.tscn")
@export_range(0, 20) var spawn_after_x_seconds : int = 5

func _ready() -> void:
	CharacterFollowSetter.get_a_to_follow_b(follower.entity_id, leader.entity_id, 1)
	var ui : ECSUi = get_tree().get_first_node_in_group("HUD")
	ui.set_run(EcsCoordinator.get_component(leader.entity_id, RunAbilityComponent))
	ui.set_jump(EcsCoordinator.get_component(leader.entity_id, JumpComponent))
	ui.set_wall_jump(EcsCoordinator.get_component(leader.entity_id, WallJumpComponent))
	ui.set_mirror(EcsCoordinator.get_component(follower.entity_id, MirrorInputComponent))
	ui.set_attack(EcsCoordinator.get_component(follower.entity_id, AttackAbility))
	get_tree().create_timer(spawn_after_x_seconds).timeout.connect(_on_void_spawn_timer_end)

func _on_void_spawn_timer_end() -> void:
	var void_entity = void_scene.instantiate()
	add_child(void_entity)
	get_void_to_follow(void_entity)

func get_void_to_follow(void_entity : Entity) -> void:
	if is_instance_valid(void_entity):
		var fc : FollowPositionComponent = EcsCoordinator.get_component(void_entity.entity_id, FollowPositionComponent)
		fc.entity_to_follow = leader.entity_id
		print("Entity to follow set to %s" % [leader.entity_id])
