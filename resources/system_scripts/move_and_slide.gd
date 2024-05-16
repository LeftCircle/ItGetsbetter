extends System
class_name MoveAndSlideSystem

var character_body_array : ComponentArray = EcsCoordinator.get_component_array(ECSCharacterBody2D)

func update(_delta : float) -> void:
	for entity in entities:
		var cbd : ECSCharacterBody2D = character_body_array.components[character_body_array.entity_to_index[entity]]
		cbd.move_and_slide()
		if cbd.is_on_wall():
			cbd.last_wall_normal = cbd.get_wall_normal()
			print("Setting cbd %s wall normal to %s" % [cbd, cbd.last_wall_normal])
			cbd.frames_since_wall_hit = 0
			cbd.wall_recently_hit = true
		elif cbd.wall_recently_hit:
			cbd.frames_since_wall_hit += 1
			if cbd.frames_since_wall_hit > cbd.frames_for_wall_recent_hit_reset:
				cbd.wall_recently_hit = false
				print("Setting recent hit to false")
