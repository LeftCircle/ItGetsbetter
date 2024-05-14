extends System
class_name UISystem


var abilities_arr : ComponentArray = EcsCoordinator.get_component_array(Abilities)
var ui_arr : ComponentArray = EcsCoordinator.get_component_array(ECSUi)

func update(delta) -> void:
	for entity in entities.keys():
		var abilities : Abilities = abilities_arr.components[abilities_arr.entity_to_index[entity]]
		var ui : ECSUi = ui_arr.components[ui_arr.entity_to_index[entity]]
		ui.jump_progress_bar.value = abilities.jump.percent
