extends System
class_name UISystem


var abilities_arr : ComponentArray = EcsCoordinator.get_component_array(Abilities)
var ui_arr : ComponentArray = EcsCoordinator.get_component_array(ECSUi)

func update(delta) -> void:
	for entity in entities.keys():
		var abilities : Abilities = abilities_arr.components[abilities_arr.entity_to_index[entity]]
		var ui : ECSUi = ui_arr.components[ui_arr.entity_to_index[entity]]
		ui.jump_progress_bar.value = abilities.jump.current_cooldown / abilities.jump.cooldown * 100
		ui.wall_jump_progress_bar.value = abilities.wall_jump.current_cooldown / abilities.wall_jump.cooldown * 100
		ui.attack_pb.value = abilities.attack.current_cooldown / abilities.attack.cooldown * 100
		ui.run_progress_bar.value = abilities.run.current_cooldown / abilities.run.cooldown * 100
		ui.mirror_pb.value = abilities.mirror_inputs.current_cooldown / abilities.mirror_inputs.cooldown * 100
