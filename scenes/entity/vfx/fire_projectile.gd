extends AnimatedSprite2D

@export var entity : Entity

func fire(dir : Vector2) -> void:
	if dir == Vector2.LEFT:
		_fire_left()
	else:
		_fire_right()

func _fire_right() -> void:
	rotation = -90
	flip_h = true

func _fire_left() -> void:
	rotation = 90
	flip_h = false

func _on_area_2d_area_entered(area: Area2D) -> void:
	entity.queue_free()
	print("entered %s" % [area.name])


func _on_area_2d_body_entered(body: Node2D) -> void:
	entity.queue_free()
	print("entered %s" % [body.name])
