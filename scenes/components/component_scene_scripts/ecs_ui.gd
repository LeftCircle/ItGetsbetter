extends Control
class_name ECSUi

@export var jump_progress_bar : TextureProgressBar
@export var run_progress_bar : TextureProgressBar
@export var wall_jump_progress_bar : TextureProgressBar
@export var mirror_pb : TextureProgressBar
@export var attack_pb : TextureProgressBar

var jump : JumpComponent
var run : RunAbilityComponent
var wall_jump : WallJumpComponent
var mirror : MirrorInputComponent
var attack : AttackAbility

var class_id : StringName : set = set_class_id
var instance_id : int

func _physics_process(_delta: float) -> void:
	set_value(jump_progress_bar, jump)
	set_value(run_progress_bar, run)
	set_value(wall_jump_progress_bar, wall_jump)
	set_value(mirror_pb, mirror)
	set_value(attack_pb, attack)

func set_value(bar : TextureProgressBar, ability : Ability) -> void:
	if is_instance_valid(ability):
		bar.value = ability.current_cooldown / ability.cooldown * 100

func set_jump(jump_comp : JumpComponent) -> void:
	jump = jump_comp

func set_run(run_comp : RunAbilityComponent) -> void:
	run = run_comp

func set_wall_jump(wall_jump_comp : WallJumpComponent) -> void:
	wall_jump = wall_jump_comp

func set_mirror(mirror_comp : MirrorInputComponent) -> void:
	mirror = mirror_comp

func set_attack(attack_comp : AttackAbility) -> void:
	attack = attack_comp

func set_class_id(new_id : StringName) -> void:
	class_id = new_id.substr(0, 3)

func _init() -> void:
	_init_class_id()

func _init_class_id() -> void:
	class_id = "CUI"

#func _ready() -> void:
	#var entity_id : int = get_parent().entity_id
	#EcsCoordinator.add_component(entity_id, self)

