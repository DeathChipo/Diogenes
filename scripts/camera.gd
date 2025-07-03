extends Camera2D

var shake_strength = 0.0
var shake_decay = 0.0
var shake_amount = 0.0

func _process(delta: float) -> void:
	if shake_strength > 0:
		var offset = Vector2(
			randf_range(-1.0, 1.0),
			randf_range(-1.0, 1.0)
		) * shake_amount * shake_strength
		if offset.length() > shake_amount:
			offset = offset.normalized() * shake_amount
		position += offset
		shake_strength = max(shake_strength - delta * shake_decay, 0)

func start_shake(strength, decay, amount):
	shake_strength = strength
	shake_decay = decay
	shake_amount = amount
