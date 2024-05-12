extends GutTest

var res_comp_group : ResourceGroup = load("res://resources/ComponentResourceGroup.tres")
var res_script_path : String = "res://resources/component_scripts/"
var scene_comp_group : ResourceGroup = load("res://scenes/components/ComponentSceneGroup.tres")
var scene_script_path : String = "res://scenes/components/component_scene_scripts/"

func test_same_number_of_component_scripts_as_resources() -> void:
	var res_comps = []
	res_comp_group.load_all_into(res_comps)
	var dir = DirAccess.get_files_at(res_script_path)
	assert_eq(dir.size(), res_comps.size(), "Number of component scripts does not match number of resources")

	var res_scenes = []
	scene_comp_group.load_all_into(res_scenes)
	dir = DirAccess.get_files_at(scene_script_path)
	assert_eq(dir.size(), res_scenes.size(), "Number of component scene scripts does not match number of resources")



func test_same_number_of_system_scripts_as_resources() -> void:
	assert_true(false, "NYI")
