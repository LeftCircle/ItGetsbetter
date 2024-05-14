extends Component
class_name Abilities

@export var run : Ability = Ability.new()
@export var jump : Ability = Ability.new()
@export var wall_jump : Ability = Ability.new()
@export var attack : Ability = Ability.new()

func _init_class_id() -> void:
	class_id = "ABI"
