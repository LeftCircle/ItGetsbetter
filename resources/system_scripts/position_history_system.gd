extends System
class_name PositionHistorySystem

var position_histories : ComponentArray = EcsCoordinator.get_component_array(PositionHistoryComponent)

func update(_delta) -> void:
	for entity in entities:
		var ph : PositionHistoryComponent = position_histories.components[position_histories.entity_to_index[entity]]
		ph.position_history.append(ph.node_to_track.global_position)
