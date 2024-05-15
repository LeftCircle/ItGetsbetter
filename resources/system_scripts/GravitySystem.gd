extends System
class_name GravitySystem

var character_body_array : ComponentArray = EcsCoordinator.get_component_array(ECSCharacterBody2D)
var gravity_arr : ComponentArray = EcsCoordinator.get_component_array(GravityComponent)

func update(delta : float) -> void:
	for entity in entities.keys():
		var cbd : ECSCharacterBody2D = character_body_array.components[character_body_array.entity_to_index[entity]]
		var on_wall : bool = cbd.is_on_wall()
		var on_floor = cbd.is_on_floor()
		if not on_floor and on_wall and cbd.velocity.y >= 0:
			cbd.velocity = cbd.velocity.move_toward(Vector2(cbd.velocity.x, cbd.wall_fall_speed), cbd.wall_acceleration * delta)
		elif not cbd.is_on_floor():
			var grav : GravityComponent = gravity_arr.components[gravity_arr.entity_to_index[entity]]
			cbd.velocity = cbd.velocity.move_toward(Vector2(cbd.velocity.x, cbd.max_fall_speed), grav.gravity * delta)
