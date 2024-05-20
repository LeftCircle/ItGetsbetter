extends System
class_name FollowPositionSystem

var position_histories : ComponentArray = EcsCoordinator.get_component_array(PositionHistoryComponent)
var follow_components : ComponentArray = EcsCoordinator.get_component_array(FollowPositionComponent)

func update(_delta) -> void:
	for entity in entities:
		var fc : FollowPositionComponent = follow_components.components[follow_components.entity_to_index[entity]]
		if position_histories.entity_to_index.has(fc.entity_to_follow):
			var ph : PositionHistoryComponent = position_histories.components[position_histories.entity_to_index[fc.entity_to_follow]]
			fc.node_to_set.global_position = ph.position_history.pop_front()
