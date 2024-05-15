extends Component
class_name Abilities

@export var run : Ability = Ability.new()
@export var jump : JumpComponent = JumpComponent.new()
@export var wall_jump : WallJumpComponent = WallJumpComponent.new()
@export var attack : Ability = Ability.new()
@export var mirror_inputs : MirrorInputComponent = MirrorInputComponent.new()

func _init_class_id() -> void:
	class_id = "ABI"
