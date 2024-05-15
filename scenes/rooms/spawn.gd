extends TileMap

@export var next_scene : PackedScene

@onready var player_char = $PlayerCharacter/ECSCharacterBody2D

func _ready() -> void:
	CharacterFollowSetter.get_a_to_follow_b($LeaverChar.entity_id, $PlayerCharacter.entity_id, 1)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player_char:
		get_tree().call_deferred("change_scene_to_packed", next_scene)
	print("Body entered %s" % [body.name])
