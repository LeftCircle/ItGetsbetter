extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CharacterFollowSetter.get_a_to_follow_b($LeaverChar.entity_id, $PlayerCharacter.entity_id, 3)
	pass
