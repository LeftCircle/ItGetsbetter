extends Component
class_name Ability

@export_range(0, 10, 0.1) var cooldown : float = 1.0;

var ready : bool = true
var percent : int = 0

func _init_class_id() -> void:
	class_id = "ABI"

func is_triggered() -> bool:
	return !ready