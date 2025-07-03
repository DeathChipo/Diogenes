extends Node

var screen_size = Vector2(1280, 720)
@export var max_offset_distance: float = 100.0

func get_camera_pos() -> Vector2:
	var camera_position = $Player.position
	var mouse_position = get_viewport().get_mouse_position()
	var vec = mouse_position - Vector2(screen_size.x / 2, screen_size.y / 2)
	if vec.length() > max_offset_distance:
		vec = vec.normalized() * max_offset_distance
	camera_position = camera_position + vec
	return camera_position

func _process(delta: float) -> void:
	$Camera.position = get_camera_pos()
	if (Input.is_action_pressed("shake")):
		$Camera.start_shake(10.0, 15.0, 20.0)
