extends AnimationTree
class_name ECSAnimationTree

var class_id : StringName : set = set_class_id
var instance_id : int

@onready var state_machine_playback : AnimationNodeStateMachinePlayback = get("parameters/playback")

func set_class_id(new_id : StringName) -> void:
	class_id = new_id.substr(0, 3)

func _init() -> void:
	_init_class_id()

func _init_class_id() -> void:
	class_id = "ANT"

func _ready() -> void:
	var entity_id : int = get_parent().entity_id
	EcsCoordinator.add_component(entity_id, self)

