extends Area2D


@export_file() var next_room

@export var leader : Entity
@export var follower : Entity

var has_leader : bool = false
var has_follower : bool = false

@onready var leader_cbd  : ECSCharacterBody2D = EcsCoordinator.get_component(leader.entity_id, ECSCharacterBody2D)
@onready var follower_cbd : ECSCharacterBody2D = EcsCoordinator.get_component(follower.entity_id, ECSCharacterBody2D)

var leader_entered : bool = false
var follower_entered : bool = false

func _on_body_entered(body: Node2D) -> void:
	if body == leader_cbd:
		has_leader = true
		print("L enter")
	if body == follower_cbd:
		has_follower = true
		print("F enter")
	if has_leader and has_follower:
		get_tree().call_deferred("change_scene_to_file", next_room)
		print("Spawning next room %s" % [next_room])

func _on_body_exited(body: Node2D) -> void:
	if body == leader_cbd:
		has_leader = false
		print("L exit")
	if body == follower_cbd:
		has_follower = false
		print("F exit")
