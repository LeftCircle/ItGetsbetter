extends Node
class_name Entity

@export var starting_components : Array[Resource] = []

var entity_id : int = EntityManager.NULL_ID

func _init() -> void:
	entity_id = EcsCoordinator.create_entity()

func _ready() -> void:
	for comp in starting_components:
		EcsCoordinator.add_component(entity_id, comp)
	starting_components.clear()
