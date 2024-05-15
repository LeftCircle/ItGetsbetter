extends CharacterBody2D
class_name ECSCharacterBody2D

@export var max_speed : int : set = set_max_speed
@export_range(1, 60) var acceleration_frames : int = 3 : set = set_acceleration_frames
@export_range(1, 1.5, 0.05) var decelleration_mod : float = 1.35
@export var jump_speed : int
@export var max_fall_speed : int = 180

var acceleration
var class_id : StringName : set = set_class_id
var instance_id : int

func set_class_id(new_id : StringName) -> void:
	class_id = new_id.substr(0, 3)

func set_max_speed(new_val : int) -> void:
	max_speed = new_val
	acceleration = max_speed / acceleration_frames * ProjectSettings.get_setting("physics/common/physics_ticks_per_second")

func set_acceleration_frames(new_val : int) -> void:
	acceleration_frames = new_val
	acceleration = max_speed / acceleration_frames * ProjectSettings.get_setting("physics/common/physics_ticks_per_second")

func _init() -> void:
	_init_class_id()

func _init_class_id() -> void:
	class_id = "CBD"

func _ready() -> void:
	var entity_id : int = get_parent().entity_id
	EcsCoordinator.add_component(entity_id, self)

