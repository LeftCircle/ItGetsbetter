extends System
class_name MoveSystem

var character_body_array : ComponentArray = EcsCoordinator.get_component_array(ECSCharacterBody2D)
var animation_trees : ComponentArray = EcsCoordinator.get_component_array(ECSAnimationTree)
var inputs : ComponentArray = EcsCoordinator.get_component_array(InputAction)
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func update(delta : float) -> void:
	for entity in entities.keys():
		var cbd : ECSCharacterBody2D = character_body_array.components[character_body_array.entity_to_index[entity]]
		var a_tree : ECSAnimationTree = animation_trees.components[animation_trees.entity_to_index[entity]]
		var input : InputAction = inputs.components[inputs.entity_to_index[entity]]
		var input_vel : Vector2 = Vector2(cbd.max_speed * input.input_vector.x, cbd.velocity.y)
		cbd.velocity = cbd.velocity.move_toward(input_vel, cbd.acceleration * delta)
		if not cbd.is_on_floor():
			cbd.velocity.y += gravity * delta
		elif cbd.is_on_floor() and Input.is_action_just_pressed("jump"):
			cbd.velocity.y = -cbd.jump_speed
		cbd.move_and_slide()
		if not is_equal_approx(cbd.velocity.length_squared(), 0):
			a_tree.set("parameters/Run/blend_position", input.input_vector.x)
			if not a_tree.state_machine_playback.get_current_node() == "Run":
				a_tree.state_machine_playback.travel("Run")
		else:
			if not a_tree.state_machine_playback.get_current_node() == "Idle":
				a_tree.state_machine_playback.travel("Idle")

