extends Component
class_name States

enum {
	IDLE,
	RUNNING,
	ATTACK
}

var current_state = IDLE

func _init_class_id() -> void:
	class_id = "STT"
