extends System
class_name ConstantMotionSystem

var c_mot_array : ComponentArray = EcsCoordinator.get_component_array(ConstantMotionComponent)

func update(delta : float) -> void:
	for entity in entities.keys():
		var c_motion : ConstantMotionComponent = c_mot_array.components[c_mot_array.entity_to_index[entity]]
		c_motion.node_to_move.global_position += c_motion.direction * c_motion.speed * delta
