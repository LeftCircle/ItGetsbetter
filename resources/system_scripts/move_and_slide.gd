extends System
class_name MoveAndSlideSystem

var character_body_array : ComponentArray = EcsCoordinator.get_component_array(ECSCharacterBody2D)

func update(_delta : float) -> void:
	for entity in entities:
		var cbd : ECSCharacterBody2D = character_body_array.components[character_body_array.entity_to_index[entity]]
		cbd.move_and_slide()
