extends Component
class_name GravityComponent

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _init_class_id() -> void:
	class_id = "GRV"
