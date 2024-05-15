extends Resource
class_name System

@export var required_components : Array = []

var entities : Dictionary = {}

func update(delta : float) -> void:
	assert(false, "Must be overwritten")

func register_entity(entity : int) -> void:
	entities[entity] = null
