extends Component
class_name Ability

@export_range(0, 10, 0.1) var cooldown : float = 1.0

var current_cooldown : float = 0
var ready : bool = true
var countdown_can_start : bool = false
var is_active : bool = false

func _init_class_id() -> void:
	class_id = "ABI"

func is_triggered() -> bool:
	return !ready
