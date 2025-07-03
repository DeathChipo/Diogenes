extends Area2D

var angle = 0
var speed = 0
var damage = 0
var speed_fix = 0

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("hittable"):
		if (body.alive):
			queue_free()
		body.hit(damage)
	if body.is_in_group("walls"):
		queue_free()

func _process(delta: float) -> void:
	if speed == 0:
		return
	position += Vector2.RIGHT.rotated(angle) * speed * delta
	rotation = angle
	$Sprite2D.flip_h = true
	while speed > speed_fix * 0.5:
		speed -= speed_fix / 1000

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func get_stats(ang, spe, dam, pos) -> void:
	position = pos
	angle = ang
	speed = spe
	speed_fix = spe
	damage = dam
