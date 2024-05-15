extends TileMap


func _ready() -> void:
	CharacterFollowSetter.get_a_to_follow_b($LeaverChar.entity_id, $PlayerCharacter.entity_id, 5)


